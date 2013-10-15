{-# LANGUAGE BangPatterns #-}
module VISA.IO
    ( Buffer
    , openDefaultRM
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
    , vxiCommandQuery, pxiReserveTriggers
    ) where

import VISA.Types
import VISA.Vpp43

import Foreign.C.String
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal.Alloc

type Buffer = Ptr ViChar

--genericWithPtr :: (Storable a) => (Ptr a -> IO c) -> (Ptr a -> IO d) -> IO (c, d)
--genericWithPtr action reader =
--    let action' ptr = do
--        result <- action ptr
--        contents <- reader ptr
--        return (result, contents)
--    in alloca action'

genericWithPtr :: (Storable a) => (Ptr a -> IO c) -> (Ptr a -> IO d) -> IO (c, d)
genericWithPtr action reader = do
    ptr <- malloc
    result <- action ptr
    contents <- reader ptr
    free ptr
    return (result, contents)

withPtr :: (Storable a) => (Ptr a -> IO c) -> IO (c, a)
withPtr action = genericWithPtr action peek

withBuf :: (Buffer -> IO a) -> IO (a, String)
withBuf action = genericWithPtr action peekCString

withViBuf :: (ViBuf -> Ptr ViUInt32 -> IO a) -> IO (a, String)
withViBuf action = do
    buf <- mallocBytes 2048 :: IO ViBuf
    (result, ctr) <- withPtr (action buf)
    chars <- mapM (peek . plusPtr buf) [0 .. fromEnum ctr - 1]
    free buf
    let buffer = map (toEnum . fromEnum :: ViByte -> Char) chars
    return (result, buffer)

withWriteBuf :: String -> (Buffer -> IO a) -> IO a
withWriteBuf buffer action = do
    buf <- newCString buffer
    result <- action buf
    free buf
    return result

genericWithPtr2 :: (Storable a1, Storable a2)
    => (Ptr a1 -> Ptr a2 -> IO b)
    -> (Ptr a1 -> IO c1) -> (Ptr a2 -> IO c2)
    -> IO (b, c1, c2)
genericWithPtr2 action reader1 reader2 = do
    ((result, contents2), contents1) <-
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
    ((result, contents2, contents3), contents1) <-
        genericWithPtr (\p1 -> genericWithPtr2 (action p1) reader2 reader3) reader1
    return (result, contents1, contents2, contents3)

--genericWithPtr4 :: (Storable a1, Storable a2, Storable a3, Storable a4)
--    => (Ptr a1 -> Ptr a2 -> Ptr a3 -> Ptr a4 -> IO b)
--    -> (Ptr a1 -> IO c1) -> (Ptr a2 -> IO c2)
--    -> (Ptr a3 -> IO c3) -> (Ptr a4 -> IO c4)
--    -> IO (b, c1, c2, c3, c4)
--genericWithPtr4 action reader1 reader2 reader3 reader4 = do
--    ((r, c2, c3, c4), c1) <-
--        genericWithPtr (\p1 -> genericWithPtr3 (action p1) reader2 reader3 reader4) reader1
--    return (r, c1, c2, c3, c4)

--------------------------------------------------------------------------------

openDefaultRM :: IO (ViStatus, ViSession)
openDefaultRM = withPtr viOpenDefaultRM

findRsrc :: ViSession -> String -> IO (ViStatus, ViFindList, ViUInt32, String)
findRsrc session rsrc = withWriteBuf rsrc $ \buf -> genericWithPtr3 (viFindRsrc session buf) peek peek peekCString

findNext :: ViFindList -> IO (ViStatus, String)
findNext fl = withBuf (viFindNext fl)

parseRsrc :: ViSession -> String -> IO (ViStatus, ViUInt16, ViUInt16)
parseRsrc session rsrc = withWriteBuf rsrc $ \buf -> genericWithPtr2 (viParseRsrc session buf) peek peek

open :: ViSession -> String -> ViAccessMode -> ViUInt32 -> IO (ViStatus, ViSession)
open session rsrc accessMode options = withWriteBuf rsrc $ \buf -> withPtr (viOpen session buf accessMode options)

close :: ViObject -> IO ViStatus
close = viClose

setAttribute :: ViObject -> ViAttr -> ViAttrState -> IO ViStatus
setAttribute = viSetAttribute

getAttribute :: ViObject -> ViAttr -> Ptr () -> IO ViStatus
getAttribute = viGetAttribute

statusDesc :: ViObject -> ViStatus -> IO (ViStatus, String)
statusDesc obj status = withBuf (viStatusDesc obj status)

terminate :: ViObject -> ViUInt16 -> ViJobId -> IO ViStatus
terminate = viTerminate

lock :: ViSession -> ViAccessMode -> ViUInt32 -> String -> IO (ViStatus, String)
lock session accessMode options keyId = withWriteBuf keyId $ \keyIdBuf -> withBuf (viLock session accessMode options keyIdBuf)

unlock :: ViSession -> IO ViStatus
unlock = viUnlock

enableEvent :: ViSession -> ViEventType -> ViUInt16 -> ViEventFilter -> IO ViStatus
enableEvent = viEnableEvent

disableEvent :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus
disableEvent = viDisableEvent

discardEvents :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus
discardEvents = viDiscardEvents

waitOnEvent :: ViSession -> ViEventType -> ViUInt32 -> IO (ViStatus, ViEventType, ViEvent)
waitOnEvent session eventType options  = withPtr2 (viWaitOnEvent session eventType options)

installHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus
installHandler = viInstallHandler

uninstallHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus
uninstallHandler = viUninstallHandler

readVi :: ViSession -> ViUInt32 -> IO (ViStatus, String)
readVi session count = withViBuf (\buf -> viRead session buf count)

readAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus
readAsync = viReadAsync

writeVi :: ViSession -> String -> IO (ViStatus, ViUInt32)
writeVi session msg = do
    buf <- malloc :: IO ViBuf
    let count = length msg
    let buffer = map (toEnum . fromEnum :: Char -> ViByte) msg
    mapM_ (\(i, c) -> plusPtr buf i `poke` c) $ zip [0 .. count - 1] buffer
    result <- withPtr $ viWrite session buf (toEnum count)
    free buf
    return result

writeAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus
writeAsync = viWriteAsync

assertTrigger :: ViSession -> ViUInt16 -> IO ViStatus
assertTrigger = viAssertTrigger

readSTB :: ViSession -> IO (ViStatus, ViUInt16)
readSTB = withPtr . viReadSTB

clear :: ViSession -> IO ViStatus
clear = viClear

setBuf :: ViSession -> ViUInt16 -> ViUInt32 -> IO ViStatus
setBuf = viSetBuf

flush :: ViSession -> ViUInt16 -> IO ViStatus
flush = viFlush

bufWrite :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus
bufWrite = viBufWrite

bufRead :: ViSession -> Ptr ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus
bufRead = viBufRead

in8 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt8 -> IO ViStatus
in8 = viIn8

out8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt8 -> IO ViStatus
out8 = viOut8

in16 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt16 -> IO ViStatus
in16 = viIn16

out16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> IO ViStatus
out16 = viOut16

in32 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt32 -> IO ViStatus
in32 = viIn32

out32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt32 -> IO ViStatus
out32 = viOut32

moveIn8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus
moveIn8 = viMoveIn8

moveOut8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus
moveOut8 = viMoveOut8

moveIn16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus
moveIn16 = viMoveIn16

moveOut16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus
moveOut16 = viMoveOut16

moveIn32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus
moveIn32 = viMoveIn32

moveOut32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus
moveOut32 = viMoveOut32

move :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> IO ViStatus
move = viMove

moveAsync :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> IO (ViStatus, ViJobId)
moveAsync vi srcSpace srcOffset srcWidth destSpace destOffset destWidth srcLength =
    withPtr $ viMoveAsync vi srcSpace srcOffset srcWidth destSpace destOffset destWidth srcLength

mapAddress :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> ViBoolean -> ViAddr -> IO (ViStatus, ViAddr)
mapAddress vi mapSpace mapOffset mapSize access suggested =
    withPtr $ viMapAddress vi mapSpace mapOffset mapSize access suggested

unmapAddress :: ViSession -> IO ViStatus
unmapAddress = viUnmapAddress

peek8 :: ViSession -> ViAddr -> Ptr ViUInt8 -> IO ViStatus
peek8 = viPeek8

poke8 :: ViSession -> ViAddr -> ViUInt8 -> IO ViStatus
poke8 = viPoke8

peek16 :: ViSession -> ViAddr -> Ptr ViUInt16 -> IO ViStatus
peek16 = viPeek16

poke16 :: ViSession -> ViAddr -> ViUInt16 -> IO ViStatus
poke16 = viPoke16

peek32 :: ViSession -> ViAddr -> Ptr ViUInt32 -> IO ViStatus
peek32 = viPeek32

poke32 :: ViSession -> ViAddr -> ViUInt32 -> IO ViStatus
poke32 = viPoke32

memAlloc :: ViSession -> ViBusSize -> IO (ViStatus, ViBusAddress)
memAlloc vi size = withPtr $ viMemAlloc vi size

memFree :: ViSession -> ViBusAddress -> IO ViStatus
memFree = viMemFree

gpibControlREN :: ViSession -> ViUInt16 -> IO ViStatus
gpibControlREN = viGpibControlREN

gpibControlATN :: ViSession -> ViUInt16 -> IO ViStatus
gpibControlATN = viGpibControlATN

gpibSendIFC :: ViSession -> IO ViStatus
gpibSendIFC = viGpibSendIFC

gpibCommand :: ViSession -> String -> IO (ViStatus, ViUInt32)
gpibCommand vi cmd = do
    buf <- malloc :: IO ViBuf
    let count = length cmd
    let buffer = map (toEnum . fromEnum :: Char -> ViByte) cmd
    mapM_ (\(i, c) -> plusPtr buf i `poke` c) $ zip [0 .. count - 1] buffer
    result <- withPtr $ viGpibCommand vi buf (toEnum count)
    free buf
    return result

gpibPassControl :: ViSession -> ViUInt16 -> ViUInt16 -> IO ViStatus
gpibPassControl = viGpibPassControl

vxiCommandQuery :: ViSession -> ViUInt16 -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus
vxiCommandQuery = viVxiCommandQuery

assertUtilSignal :: ViSession -> ViUInt16 -> IO ViStatus
assertUtilSignal = viAssertUtilSignal

assertIntrSignal :: ViSession -> ViInt16 -> ViUInt32 -> IO ViStatus
assertIntrSignal = viAssertIntrSignal

mapTrigger :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> IO ViStatus
mapTrigger = viMapTrigger

unmapTrigger :: ViSession -> ViInt16 -> ViInt16 -> IO ViStatus
unmapTrigger = viUnmapTrigger

usbControlOut :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> ViBuf -> IO ViStatus
usbControlOut = viUsbControlOut

usbControlIn :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> Ptr ViBuf -> Ptr ViUInt16 -> IO ViStatus
usbControlIn = viUsbControlIn

pxiReserveTriggers :: ViSession -> ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> IO ViStatus
pxiReserveTriggers = viPxiReserveTriggers
