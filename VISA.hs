{-# LANGUAGE DoAndIfThenElse            #-}
{-# LANGUAGE BangPatterns               #-}
module VISA
    ( module VISA.Trans

    , getSession, getStatusDesc, errorHandle
    , scanForInstruments
    , openVisa, closeVisa
    , readVisa, writeVisa, queryVisa
    , clearVisa
    ) where

import VISA.Types
import VISA.Consts
import VISA.Trans
import qualified VISA.IO as Vi

import Control.Monad

--------------------------------------------------------------------------------

getSession :: MonadIO m => VisaT m ViSession
getSession = do
    vi <- get
    case visaSession vi of
        Nothing -> do
            (status, session) <- liftIO $! Vi.openDefaultRM
            if status /= 0 then do
                (status', desc) <- liftIO $! Vi.statusDesc session status
                when (status' /= 0) $
                    throwError (status', "Could not get status description.")
                throwError (status, desc)
            else do
                put $ Visa $ Just session
                return session
        Just session -> return session

getStatusDesc :: MonadIO m => ViStatus -> VisaT m String
getStatusDesc status = do
    session <- getSession
    (status', desc) <- liftIO $! Vi.statusDesc session status
    when (status' /= 0) $
        throwError (status', "Could not get status description.")
    return desc

errorHandle :: MonadIO m => ViStatus -> VisaT m ()
errorHandle !status = when (status /= 0) $ do
    desc <- getStatusDesc status
    throwError (status, desc)

scanForInstruments :: MonadIO m => VisaT m [String]
scanForInstruments = do
    session <- getSession
    (status, fl, ctr, first) <- liftIO $! Vi.findRsrc session "?*"
    errorHandle status
    (statuses, rest) <- liftIO $! fmap unzip $ replicateM (fromEnum ctr - 1) $ Vi.findNext fl
    mapM_ errorHandle statuses
    return $ first : rest

openVisa :: MonadIO m => String -> VisaT m ()
openVisa addr = do
    session <- getSession
    (status, newSession) <- liftIO $! Vi.open session addr viNoLock viTmoImmediate
    errorHandle status
    closeVisa
    put $ Visa $ Just newSession

closeVisa :: MonadIO m => VisaT m ()
closeVisa = do
    session <- getSession
    status <- liftIO $! Vi.close session
    errorHandle status
    put $ Visa Nothing

readVisa :: MonadIO m => VisaT m String
readVisa = do
    session <- getSession
    (status, msg) <- liftIO $! Vi.readVi session 256
    errorHandle status
    if length msg < 256
        then return msg
        else readVisa >>= return . (++) msg

writeVisa :: MonadIO m => String -> VisaT m ()
writeVisa msg = do
    session <- getSession
    (status, _) <- liftIO $! Vi.writeVi session msg
    errorHandle status

queryVisa :: MonadIO m => String -> VisaT m String
queryVisa msg = writeVisa msg >> readVisa

clearVisa :: MonadIO m => VisaT m ()
clearVisa = do
    session <- getSession
    status <- liftIO $! Vi.clear session
    errorHandle status
