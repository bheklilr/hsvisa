{-# LANGUAGE ForeignFunctionInterface #-}
module VISA.Driver.Vpp43
    ( viOpenDefaultRM
    , viFindRsrc
    , viFindNext
    , viParseRsrc
    , viOpen
    , viClose
    , viSetAttribute
    , viGetAttribute
    , viStatusDesc
    , viTerminate
    , viLock
    , viUnlock
    , viEnableEvent
    , viDisableEvent
    , viDiscardEvents
    , viWaitOnEvent
    , viInstallHandler
    , viUninstallHandler
    , viRead
    , viReadAsync
    , viReadToFile
    , viWrite
    , viWriteAsync
    , viWriteFromFile
    , viAssertTrigger
    , viReadSTB
    , viClear
    , viSetBuf
    , viFlush
    , viBufWrite
    , viBufRead
    , viIn8
    , viOut8
    , viIn16
    , viOut16
    , viIn32
    , viOut32
    , viMoveIn8
    , viMoveOut8
    , viMoveIn16
    , viMoveOut16
    , viMoveIn32
    , viMoveOut32
    , viMove
    , viMoveAsync
    , viMapAddress
    , viUnmapAddress
    , viPeek8
    , viPoke8
    , viPeek16
    , viPoke16
    , viPeek32
    , viPoke32
    , viMemAlloc
    , viMemFree
    , viGpibControlREN
    , viGpibControlATN
    , viGpibSendIFC
    , viGpibCommand
    , viGpibPassControl
    , viVxiCommandQuery
    , viAssertUtilSignal
    , viAssertIntrSignal
    , viMapTrigger
    , viUnmapTrigger
    , viUsbControlOut
    , viUsbControlIn
    --, viPxiReserveTriggers
    ) where

import Foreign
import Foreign.C.Types

import VISA.Driver.Types


foreign import ccall "visa.h viOpenDefaultRM"
    viOpenDefaultRM :: Ptr ViSession -> IO ViStatus

foreign import ccall "visa.h viFindRsrc"
    viFindRsrc :: ViSession -> ViString -> Ptr ViFindList -> Ptr ViUInt32 -> ViString -> IO ViStatus

foreign import ccall "visa.h viFindNext"
    viFindNext :: ViFindList -> ViString -> IO ViStatus

foreign import ccall "visa.h viParseRsrc"
    viParseRsrc :: ViSession -> ViRsrc -> Ptr ViUInt16 -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viOpen"
    viOpen :: ViSession -> ViRsrc -> ViAccessMode -> ViUInt32 -> Ptr ViSession -> IO ViStatus

foreign import ccall "visa.h viClose"
    viClose :: ViObject -> IO ViStatus

foreign import ccall "visa.h viSetAttribute"
    viSetAttribute :: ViObject -> ViAttr -> ViAttrState -> IO ViStatus

foreign import ccall "visa.h viGetAttribute"
    viGetAttribute :: ViObject -> ViAttr -> Ptr () -> IO ViStatus

foreign import ccall "visa.h viStatusDesc"
    viStatusDesc :: ViObject -> ViStatus -> ViString -> IO ViStatus

foreign import ccall "visa.h viTerminate"
    viTerminate :: ViObject -> ViUInt16 -> ViJobId -> IO ViStatus

foreign import ccall "visa.h viLock"
    viLock :: ViSession -> ViAccessMode -> ViUInt32 -> ViKeyId -> ViString -> IO ViStatus

foreign import ccall "visa.h viUnlock"
    viUnlock :: ViSession -> IO ViStatus

foreign import ccall "visa.h viEnableEvent"
    viEnableEvent :: ViSession -> ViEventType -> ViUInt16 -> ViEventFilter -> IO ViStatus

foreign import ccall "visa.h viDisableEvent"
    viDisableEvent :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viDiscardEvents"
    viDiscardEvents :: ViSession -> ViEventType -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viWaitOnEvent"
    viWaitOnEvent :: ViSession -> ViEventType -> ViUInt32 -> Ptr ViEventType -> Ptr ViEvent -> IO ViStatus

foreign import ccall "visa.h viInstallHandler"
    viInstallHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus

foreign import ccall "visa.h viUninstallHandler"
    viUninstallHandler :: ViSession -> ViEventType -> ViHndlr -> ViAddr -> IO ViStatus

foreign import ccall "visa.h viRead"
    viRead :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viReadAsync"
    viReadAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus

foreign import ccall "visa.h viReadToFile"
    viReadToFile :: ViSession -> ViConstString -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viWrite"
    viWrite :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viWriteAsync"
    viWriteAsync :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViJobId -> IO ViStatus

foreign import ccall "visa.h viWriteFromFile"
    viWriteFromFile :: ViSession -> ViConstString -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viAssertTrigger"
    viAssertTrigger :: ViSession -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viReadSTB"
    viReadSTB :: ViSession -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viClear"
    viClear :: ViSession -> IO ViStatus

foreign import ccall "visa.h viSetBuf"
    viSetBuf :: ViSession -> ViUInt16 -> ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viFlush"
    viFlush :: ViSession -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viBufWrite"
    viBufWrite :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viBufRead"
    viBufRead :: ViSession -> Ptr ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viIn8"
    viIn8 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viOut8"
    viOut8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viIn16"
    viIn16 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viOut16"
    viOut16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viIn32"
    viIn32 :: ViSession -> ViUInt16 -> ViBusAddress -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viOut32"
    viOut32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viMoveIn8"
    viMoveIn8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viMoveOut8"
    viMoveOut8 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viMoveIn16"
    viMoveIn16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viMoveOut16"
    viMoveOut16 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viMoveIn32"
    viMoveIn32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viMoveOut32"
    viMoveOut32 :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viMove"
    viMove :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> IO ViStatus

foreign import ccall "visa.h viMoveAsync"
    viMoveAsync :: ViSession -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViUInt16 -> ViBusAddress -> ViUInt16 -> ViBusSize -> Ptr ViJobId -> IO ViStatus

foreign import ccall "visa.h viMapAddress"
    viMapAddress :: ViSession -> ViUInt16 -> ViBusAddress -> ViBusSize -> ViBoolean -> ViAddr -> Ptr ViAddr -> IO ViStatus

foreign import ccall "visa.h viUnmapAddress"
    viUnmapAddress :: ViSession -> IO ViStatus

foreign import ccall "visa.h viPeek8"
    viPeek8 :: ViSession -> ViAddr -> Ptr ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viPoke8"
    viPoke8 :: ViSession -> ViAddr -> ViUInt8 -> IO ViStatus

foreign import ccall "visa.h viPeek16"
    viPeek16 :: ViSession -> ViAddr -> Ptr ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viPoke16"
    viPoke16 :: ViSession -> ViAddr -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viPeek32"
    viPeek32 :: ViSession -> ViAddr -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viPoke32"
    viPoke32 :: ViSession -> ViAddr -> ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viMemAlloc"
    viMemAlloc :: ViSession -> ViBusSize -> Ptr ViBusAddress -> IO ViStatus

foreign import ccall "visa.h viMemFree"
    viMemFree :: ViSession -> ViBusAddress -> IO ViStatus

foreign import ccall "visa.h viGpibControlREN"
    viGpibControlREN :: ViSession -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viGpibControlATN"
    viGpibControlATN :: ViSession -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viGpibSendIFC"
    viGpibSendIFC :: ViSession -> IO ViStatus

foreign import ccall "visa.h viGpibCommand"
    viGpibCommand :: ViSession -> ViBuf -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viGpibPassControl"
    viGpibPassControl :: ViSession -> ViUInt16 -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viVxiCommandQuery"
    viVxiCommandQuery :: ViSession -> ViUInt16 -> ViUInt32 -> Ptr ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viAssertUtilSignal"
    viAssertUtilSignal :: ViSession -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viAssertIntrSignal"
    viAssertIntrSignal :: ViSession -> ViInt16 -> ViUInt32 -> IO ViStatus

foreign import ccall "visa.h viMapTrigger"
    viMapTrigger :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> IO ViStatus

foreign import ccall "visa.h viUnmapTrigger"
    viUnmapTrigger :: ViSession -> ViInt16 -> ViInt16 -> IO ViStatus

foreign import ccall "visa.h viUsbControlOut"
    viUsbControlOut :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> ViBuf -> IO ViStatus

foreign import ccall "visa.h viUsbControlIn"
    viUsbControlIn :: ViSession -> ViInt16 -> ViInt16 -> ViUInt16 -> ViUInt16 -> ViUInt16 -> Ptr ViBuf -> Ptr ViUInt16 -> IO ViStatus

--foreign import ccall "visa.h viPxiReserveTriggers"
--    viPxiReserveTriggers :: ViSession -> ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> Ptr ViInt16 -> IO ViStatus
