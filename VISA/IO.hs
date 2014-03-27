{-# LANGUAGE BangPatterns #-}
module VISA.IO
    ( module VISA.Trans

    , getSession, getRsrcMgr

    , openDefaultRM
    , findRsrc, findNext, parseRsrc
    , open, close
    , setAttribute, getAttribute
    , statusDesc
    , terminate
    , lock, unlock
    , enableEvent, disableEvent, discardEvents --, waitOnEvent
    --, installHandler, uninstallHandler
    , readVi --, readAsync, readSTB
    , writeVi --, writeAsync
    --, assertTrigger
    --, clear, setBuf, flush
    --, bufWrite, bufRead
    --, in8, in16, in32
    --, out8, out16, out32
    --, moveIn8, moveIn16, moveIn32
    --, moveOut8, moveOut16, moveOut32
    --, move, moveAsync
    --, mapAddress, unmapAddress
    --, peek8, peek16, peek32
    --, poke8, poke16, poke32
    --, memAlloc, memFree
    --, gpibControlREN, gpibControlATN, gpibSendIFC, gpibCommand, gpibPassControl
    --, assertUtilSignal, assertIntrSignal
    --, mapTrigger, unmapTrigger
    --, usbControlOut, usbControlIn
    --, vxiCommandQuery
    ) where


import VISA.Trans
import VISA.Driver.Types
import VISA.Driver.VppConsts
import qualified VISA.Driver.IO as Vi

import Data.Foldable (forM_)
import Control.Monad (when, unless)

--------------------------------------------------------------------------------

successCodes :: Integral a => [a]
successCodes =
    [ viSuccess
    , viSuccessEventEn
    , viSuccessEventDis
    , viSuccessQueueEmpty
    , viSuccessTermChar
    , viSuccessMaxCnt
    , viSuccessDevNpresent
    , viSuccessTrigMapped
    , viSuccessQueueNempty
    , viSuccessNchain
    , viSuccessNestedShared
    , viSuccessNestedExclusive
    , viSuccessSync]

-- | Checks if the status is an error code, and if so it gets the error message
-- and throws the error.
errorHandle :: MonadIO io => ViStatus -> VisaT io ()
errorHandle !status = unless (status `elem` successCodes) $ do
    Visa _ rm <- get
    case rm of
        Just vi -> do
            (stat, desc) <- liftIO $ Vi.statusDesc vi status
            when (stat == 0) $ do
                liftIO $ Vi.close vi
                throwError (status, desc)
        Nothing -> throwError (status, "")

getSession :: MonadIO m => VisaT m ViSession
getSession = do
    Visa sesn _ <- get
    case sesn of
        Just vi -> return vi
        Nothing -> openDefaultRM

getRsrcMgr :: MonadIO m => VisaT m ViSession
getRsrcMgr = do
    Visa _ rm <- get
    case rm of
        Just vi -> return vi
        Nothing -> openDefaultRM

putSession :: MonadIO io => ViSession -> VisaT io ()
putSession sesn = do
    Visa oldSesn rm <- get
    forM_ oldSesn close  -- Closes if oldSesn is Just vi
    put $ Visa (Just sesn) rm

openDefaultRM :: MonadIO m => VisaT m ViSession
openDefaultRM = do
    Visa sesn rm <- get
    case rm of
        Nothing -> do
            (status, vi) <- liftIO Vi.openDefaultRM
            errorHandle status
            put $ Visa sesn (Just vi)
            return vi
        Just vi -> return vi

findRsrc :: MonadIO io => String -> VisaT io (ViFindList, ViUInt32, String)
findRsrc rsrcName = do
    vi <- getRsrcMgr
    (status, fl, cnt, first) <- liftIO $ Vi.findRsrc vi rsrcName
    errorHandle status
    return (fl, cnt, first)

findNext :: MonadIO io => ViFindList -> VisaT io String
findNext fl = do
    (status, next) <- liftIO $ Vi.findNext fl
    errorHandle status
    return next

parseRsrc :: MonadIO io => String -> VisaT io (ViUInt16, ViUInt16)
parseRsrc rsrc = do
    rm <- getRsrcMgr
    (status, intfType, intfNum) <- liftIO $ Vi.parseRsrc rm rsrc
    errorHandle status
    return (intfType, intfNum)

open :: MonadIO io => String -> ViAccessMode -> ViUInt32 -> VisaT io ViSession
open rsrc accessMode openTimout = do
    rm <- getRsrcMgr
    (status, sesn) <- liftIO $ Vi.open rm rsrc accessMode openTimout
    errorHandle status
    putSession sesn
    return sesn

close :: MonadIO io => ViSession -> VisaT io ()
close sesn = liftIO (Vi.close sesn) >>= errorHandle

setAttribute :: MonadIO io => ViAttr -> ViAttrState -> VisaT io ()
setAttribute attribute attrState = do
    vi <- getSession
    liftIO (Vi.setAttribute vi attribute attrState) >>= errorHandle

getAttribute :: MonadIO io => ViObject -> ViAttr -> VisaT io ViAttrState
getAttribute vi attribute = do
    (status, attrState) <- liftIO $ Vi.getAttribute vi attribute
    errorHandle status
    return attrState

statusDesc :: MonadIO io => ViObject -> ViStatus -> VisaT io String
statusDesc vi status = do
    (stat, msg) <- liftIO $ Vi.statusDesc vi status
    errorHandle stat
    return msg

terminate :: MonadIO io => ViObject -> ViUInt16 -> ViJobId -> VisaT io ()
terminate vi degree jobId = liftIO (Vi.terminate vi degree jobId) >>= errorHandle

lock :: MonadIO io => ViAccessMode -> ViUInt32 -> String -> VisaT io String
lock lockType timeout requestedKey = do
    vi <- getSession
    (status, accessKey) <- liftIO $ Vi.lock vi lockType timeout requestedKey
    errorHandle status
    return accessKey

unlock :: MonadIO io => VisaT io ()
unlock = getSession >>= liftIO . Vi.unlock >>= errorHandle

enableEvent :: MonadIO io => ViEventType -> ViUInt16 -> ViEventFilter -> VisaT io ()
enableEvent eventType mechanism context = do
    vi <- getSession
    liftIO (Vi.enableEvent vi eventType mechanism context) >>= errorHandle

disableEvent :: MonadIO io => ViEventType -> ViUInt16 -> VisaT io ()
disableEvent eventType mechanism = do
    vi <- getSession
    liftIO (Vi.disableEvent vi eventType mechanism) >>= errorHandle

discardEvents :: MonadIO io => ViEventType -> ViUInt16 -> VisaT io ()
discardEvents eventType mechanism = do
    vi <- getSession
    liftIO (Vi.discardEvents vi eventType mechanism) >>= errorHandle

--waitOnEvent

--installHandler

--uninstallHandler

readVi :: MonadIO io => ViUInt32 -> VisaT io String
readVi cnt = do
    vi <- getSession
    (status, msg) <- liftIO $ Vi.readVi vi cnt
    errorHandle status
    return msg

--readAsync

--readSTB

writeVi :: MonadIO io => String -> VisaT io ViUInt32
writeVi msg = do
    vi <- getSession
    (status, cnt) <- liftIO $ Vi.writeVi vi msg
    errorHandle status
    return cnt

--writeAsync

--assertTrigger

--clear :: MonadIO m =>
--clear

--setBuf

--flush :: MonadIO m =>
--flush

--bufWrite

--bufRead

--in8

--in16

--in32

--out8

--out16

--out32

--moveIn8

--moveIn16

--moveIn32

--moveOut8

--moveOut16

--moveOut32

--move

--moveAsync

--mapAddress

--unmapAddress

--peek8

--peek16

--peek32

--poke8

--poke16

--poke32

--memAlloc

--memFree

--gpibControlREN

--gpibControlATN

--gpibSendIFC

--gpibCommand

--gpibPassControl

--assertUtilSignal

--assertIntrSignal

--mapTrigger

--unmapTrigger

--usbControlOut

--usbControlIn

--vxiCommandQuery
