{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE BangPatterns #-}
-- | This module contains a function mirroring each foriegn function but hides
-- the need to use pointer logic directly.  Each function is written in such a
-- way to make it pointer safe.
module VISA.Driver.IO
    ( openDefaultRM
    , findRsrc, findNext, parseRsrc
    , open, close
    , setAttribute, getAttribute
    , statusDesc
    , terminate
    , lock, unlock
    , enableEvent, disableEvent, discardEvents, waitOnEvent
    , installHandler, uninstallHandler
    , readVi, readAsync, readSTB
    , writeVi, writeAsync
    , assertTrigger
    , clear, setBuf, flush
    , bufWrite, bufRead
    , in8, in16, in32
    , out8, out16, out32
    , moveIn8, moveIn16, moveIn32
    , moveOut8, moveOut16, moveOut32
    , move, moveAsync
    , mapAddress, unmapAddress
    , peek8, peek16, peek32
    , poke8, poke16, poke32
    , memAlloc, memFree
    , gpibControlREN, gpibControlATN, gpibSendIFC, gpibCommand, gpibPassControl
    , assertUtilSignal, assertIntrSignal
    , mapTrigger, unmapTrigger
    , usbControlOut, usbControlIn
    , vxiCommandQuery
    --, pxiReserveTriggers
    ) where

import VISA.Driver.Types
import VISA.Driver.Vpp43

import Foreign.C.String
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal.Alloc

import Control.Monad (zipWithM_)

type Buffer = Ptr ViChar

genericWithPtr :: (Storable a) => (Ptr a -> IO c) -> (Ptr a -> IO d) -> IO (c, d)
genericWithPtr action reader =
    let action' ptr = do
        !result <- action ptr
        !contents <- reader ptr
        return (result, contents)
    in alloca action'

withPtr :: (Storable a) => (Ptr a -> IO c) -> IO (c, a)
withPtr action = genericWithPtr action peek

withBuf :: (Buffer -> IO a) -> IO (a, String)
withBuf action = genericWithPtr action peekCString

withReadViBuf :: Integral i => i -> (ViBuf -> Ptr ViUInt32 -> IO a) -> IO (a, String)
withReadViBuf count action = allocaBytes (fromIntegral count) $ \buf -> do
    (!result, !ctr) <- withPtr (action buf)
    !string <- mapM (fmap castCUCharToChar . peek . plusPtr buf) [0 .. fromIntegral ctr - 1]
    return (result, string)

withWriteBuf :: String -> (Buffer -> IO a) -> IO a
withWriteBuf = withCString

withReadBuf :: String -> (Buffer -> IO a) -> IO (a, String)
withReadBuf buffer action = withCString buffer $ \buf -> do
    !result <- action buf
    !string <- peekCString buf
    return (result, string)

genericWithPtr2 :: (Storable a1, Storable a2)
    => (Ptr a1 -> Ptr a2 -> IO b)
    -> (Ptr a1 -> IO c1) -> (Ptr a2 -> IO c2)
    -> IO (b, c1, c2)
genericWithPtr2 action reader1 reader2 = do
    ((!result, !contents2), !contents1) <-
        genericWithPtr (\p1 -> genericWithPtr (action p1) reader2) reader1
    return (result, contents1, contents2)

withPtr2 :: (Storable a1, Storable a2)
    => (Ptr a1 -> Ptr a2 -> IO b)
    -> IO (b, a1, a2)
withPtr2 action = genericWithPtr2 action peek peek

genericWithPtr3 :: (Storable a1, Storable a2, Storable a3)
    => (Ptr a1 -> Ptr a2 -> Ptr a3 -> IO b)
    -> (Ptr a1 -> IO c1) -> (Ptr a2 -> IO c2) -> (Ptr a3 -> IO c3)
    -> IO (b, c1, c2, c3)
genericWithPtr3 action reader1 reader2 reader3 = do
    ((!result, !contents2, !contents3), !contents1) <-
        genericWithPtr (\p1 -> genericWithPtr2 (action p1) reader2 reader3) reader1
    return (result, contents1, contents2, contents3)

--------------------------------------------------------------------------------

buffer1024 :: String
buffer1024 = replicate 1024 ' '

-- | Opens the default resource manager.
openDefaultRM :: IO (ViStatus, ViSession)
openDefaultRM = withPtr viOpenDefaultRM

-- | Finds a resource based on the search string.
findRsrc :: ViSession -> String -> IO (ViStatus, ViFindList, ViUInt32, String)
findRsrc session rsrc = do
    ((!status, !fl, !cnt), !string) <-
        withWriteBuf rsrc $ \rsrcP ->
            withReadBuf buffer1024 $ \buf ->
                withPtr2 (\flP cntP -> viFindRsrc session rsrcP flP cntP buf)
    return (status, fl, cnt, string)

-- | Used in conjunction with 'findRsrc' to return all the resources found from a search.
findNext :: ViFindList -> IO (ViStatus, String)
findNext fl = withReadBuf buffer1024 $ viFindNext fl

-- | Parses a resource name to retrieve more information about it.
parseRsrc :: ViSession -> String -> IO (ViStatus, ViUInt16, ViUInt16)
parseRsrc session rsrc = withWriteBuf rsrc $ \buf -> withPtr2 (viParseRsrc session buf)

-- | Opens a connection to a resource.
open :: ViSession -> String -> ViAccessMode -> ViUInt32 -> IO (ViStatus, ViSession)
open session rsrc accessMode openTimeout =
    withWriteBuf rsrc $ \rsrcP ->
        withPtr (viOpen session rsrcP accessMode openTimeout)

-- | Closes a a ViObject, such as a ViSession, ViFindList, or ViRsrc.
close :: ViObject -> IO ViStatus
close = viClose

-- | Sets a resource attribute value.
setAttribute :: ViObject -> ViAttr -> ViAttrState -> IO ViStatus
setAttribute = viSetAttribute

-- | Gets the value associated with a resource attribute.
getAttribute :: Storable a => ViObject -> ViAttr -> IO (ViStatus, a)
getAttribute vi attribute = alloca $ \ptr -> do
        !status <- viGetAttribute vi attribute (castPtr ptr)
        !contents <- peek ptr
        return (status, contents)

-- | Gets the description associated with a status code.
statusDesc :: ViObject -> ViStatus -> IO (ViStatus, String)
statusDesc obj status = withReadBuf buffer1024 (viStatusDesc obj status)

-- | Terminates a Job.
terminate :: ViObject -> ViUInt16 -> ViJobId -> IO ViStatus
terminate = viTerminate

-- | Performs a lock on the session.
lock :: ViSession -> ViAccessMode -> ViUInt32 -> String -> IO (ViStatus, String)
lock session accessMode options keyId =
    withWriteBuf keyId $ \keyIdBuf ->
        withBuf (viLock session accessMode options keyIdBuf)

-- | Unlokcs a session.
unlock :: ViSession -> IO ViStatus
unlock = viUnlock

-- | Enables an event.
enableEvent :: ViSession -> ViEventType -> ViUInt16 -> ViEventFilter -> IO ViStatus
enableEvent = viEnableEvent

-- | Disables an event.
disableEvent :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus
disableEvent = viDisableEvent

-- | Discards all events of the given type.
discardEvents :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus
discardEvents = viDiscardEvents

-- | Waits for an event to occur.
waitOnEvent :: ViSession -> ViEventType -> ViUInt32 -> IO (ViStatus, ViEventType, ViEvent)
waitOnEvent session eventType options  = withPtr2 (viWaitOnEvent session eventType options)

-- | Installs an event handler.
installHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus
installHandler = viInstallHandler

-- | Uninstalls an event handler.
uninstallHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus
uninstallHandler = viUninstallHandler

-- | Reads a response from the VISA interface.
readVi :: ViSession -> ViUInt32 -> IO (ViStatus, String)
readVi session count = withReadViBuf count (\buf -> viRead session buf count)

-- | Reads a response from the VISA interface asynchronously.
readAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus
readAsync = viReadAsync

-- | Writes a command to the VISA interface.
writeVi :: ViSession -> String -> IO (ViStatus, ViUInt32)
writeVi session msg = do
    let count = length msg
    allocaBytes count $ \buf -> do
        let buffer = map castCharToCUChar msg
        zipWithM_ (poke . plusPtr buf) [0 .. count - 1] buffer
        withPtr (viWrite session buf (toEnum count))

-- | Writes a command to the VISA interface asynchronously.
writeAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus
writeAsync = viWriteAsync

-- | Asserts a trigger (?).
assertTrigger :: ViSession -> ViUInt16 -> IO ViStatus
assertTrigger = viAssertTrigger

-- | Reads the status byte.
readSTB :: ViSession -> IO (ViStatus, ViUInt16)
readSTB = withPtr . viReadSTB

-- | Clears a VISA session.
clear :: ViSession -> IO ViStatus
clear = viClear

-- | Sets buffer parameters.
setBuf :: ViSession -> ViUInt16 -> ViUInt32 -> IO ViStatus
setBuf = viSetBuf

-- | Flushes any buffered data to the interface.
flush :: ViSession -> ViUInt16 -> IO ViStatus
flush = viFlush

-- | Writes to the buffer.
bufWrite :: ViSession -> String -> IO (ViStatus, ViUInt32)
bufWrite session msg = do
    let count = length msg
    buf <- mallocBytes count
    let buffer = map castCharToCUChar msg
    mapM_ (\(i, c) -> poke (plusPtr buf i) c) $ zip [0 .. count - 1] buffer
    --mapM_ (\(i, c) -> plusPtr buf i `poke` c) $ zip [0 .. count - 1] buffer
    result <- withPtr $ viWrite session buf (toEnum count)
    free buf
    return result

-- | Reads from the buffer.
bufRead :: ViSession -> ViUInt32 -> IO (ViStatus, String)
bufRead session count = do
    buf <- mallocBytes (fromIntegral count)
    res <- alloca $ \ctrP -> do
        !status <- viRead session buf count ctrP
        !ctr    <- peek ctrP
        !string <- mapM (fmap castCUCharToChar . peek . plusPtr buf) [0 .. fromIntegral count - 1]
        return (status, string)
    free buf
    return res

-- | Reads 8 bits.
in8 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt8 -> IO ViStatus
in8 = viIn8

-- | Writes 8 bits.
out8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt8 -> IO ViStatus
out8 = viOut8

-- | Reads 16 bits.
in16 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt16 -> IO ViStatus
in16 = viIn16

-- | Writes 16 bits.
out16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> IO ViStatus
out16 = viOut16

-- | Reads 32 bits.
in32 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt32 -> IO ViStatus
in32 = viIn32

-- | Writes 32 bits
out32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt32 -> IO ViStatus
out32 = viOut32

-- | ?
moveIn8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus
moveIn8 = viMoveIn8

-- | ?
moveOut8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus
moveOut8 = viMoveOut8

-- | ?
moveIn16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus
moveIn16 = viMoveIn16

-- | ?
moveOut16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus
moveOut16 = viMoveOut16

-- | ?
moveIn32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus
moveIn32 = viMoveIn32

-- | ?
moveOut32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus
moveOut32 = viMoveOut32

-- | ?
move :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> IO ViStatus
move = viMove

-- | ?
moveAsync :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> IO (ViStatus, ViJobId)
moveAsync vi srcSpace srcOffset srcWidth destSpace destOffset destWidth srcLength =
    withPtr $ viMoveAsync vi srcSpace srcOffset srcWidth destSpace destOffset destWidth srcLength

-- | ?
mapAddress :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> ViBoolean -> ViAddr -> IO (ViStatus, ViAddr)
mapAddress vi mapSpace mapOffset mapSize access suggested =
    withPtr $ viMapAddress vi mapSpace mapOffset mapSize access suggested

-- | ?
unmapAddress :: ViSession -> IO ViStatus
unmapAddress = viUnmapAddress

-- | Peeks at the byte at the given address.
peek8 :: ViSession -> ViAddr -> Ptr ViUInt8 -> IO ViStatus
peek8 = viPeek8

-- | Pokes a byte into the given address.
poke8 :: ViSession -> ViAddr -> ViUInt8 -> IO ViStatus
poke8 = viPoke8

-- | Peeks at 2 bytes at the given address.
peek16 :: ViSession -> ViAddr -> Ptr ViUInt16 -> IO ViStatus
peek16 = viPeek16

-- | Pokes 2 bytes into the given address.
poke16 :: ViSession -> ViAddr -> ViUInt16 -> IO ViStatus
poke16 = viPoke16

-- | Peeks 4 bytes at the given address
peek32 :: ViSession -> ViAddr -> Ptr ViUInt32 -> IO ViStatus
peek32 = viPeek32

-- | Pokes 4 bytes at the given address
poke32 :: ViSession -> ViAddr -> ViUInt32 -> IO ViStatus
poke32 = viPoke32

-- | Allocates shared memory.
memAlloc :: ViSession -> ViBusSize -> IO (ViStatus, ViBusAddress)
memAlloc vi size = withPtr $ viMemAlloc vi size

-- | Frees shared memory.
memFree :: ViSession -> ViBusAddress -> IO ViStatus
memFree = viMemFree

-- | ?
gpibControlREN :: ViSession -> ViUInt16 -> IO ViStatus
gpibControlREN = viGpibControlREN

-- | ?
gpibControlATN :: ViSession -> ViUInt16 -> IO ViStatus
gpibControlATN = viGpibControlATN

-- | ?
gpibSendIFC :: ViSession -> IO ViStatus
gpibSendIFC = viGpibSendIFC

-- | ?
gpibCommand :: ViSession -> String -> IO (ViStatus, ViUInt32)
gpibCommand vi cmd = do
    buf <- malloc :: IO ViBuf
    let count = length cmd
    let buffer = map (toEnum . fromEnum :: Char -> ViByte) cmd
    mapM_ (\(i, c) -> plusPtr buf i `poke` c) $ zip [0 .. count - 1] buffer
    result <- withPtr $ viGpibCommand vi buf (toEnum count)
    free buf
    return result

-- | ?
gpibPassControl :: ViSession -> ViUInt16 -> ViUInt16 -> IO ViStatus
gpibPassControl = viGpibPassControl

-- | ?
vxiCommandQuery :: ViSession -> ViUInt16 -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus
vxiCommandQuery = viVxiCommandQuery

-- | ?
assertUtilSignal :: ViSession -> ViUInt16 -> IO ViStatus
assertUtilSignal = viAssertUtilSignal

-- | ?
assertIntrSignal :: ViSession -> ViInt16 -> ViUInt32 -> IO ViStatus
assertIntrSignal = viAssertIntrSignal

-- | ?
mapTrigger :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> IO ViStatus
mapTrigger = viMapTrigger

-- | ?
unmapTrigger :: ViSession -> ViInt16 -> ViInt16 -> IO ViStatus
unmapTrigger = viUnmapTrigger

-- | ?
usbControlOut :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> ViBuf -> IO ViStatus
usbControlOut = viUsbControlOut

-- | ?
usbControlIn :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> Ptr ViBuf -> Ptr ViUInt16 -> IO ViStatus
usbControlIn = viUsbControlIn

--pxiReserveTriggers :: ViSession -> ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> IO ViStatus
--pxiReserveTriggers = viPxiReserveTriggers
