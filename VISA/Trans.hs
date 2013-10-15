{-# OPTIONS_GHC -fno-warn-orphans       #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeSynonymInstances       #-}
{-# LANGUAGE FlexibleInstances          #-}
module VISA.Trans
    ( Visa(..)
    , VisaError, VisaResult

    , VisaT
    , runVisaT, execVisaT, execVisaT'
    , runWithVisaT, execWithVisaT, execWithVisaT'

    , VisaIO
    , runVisaIO, execVisaIO, execVisaIO'
    , runWithVisaIO, execWithVisaIO, execWithVisaIO'

    , MonadIO, MonadError, MonadState
    , liftIO
    , throwError, catchError
    , get, put
    ) where


import VISA.Types

import Control.Monad.Error
import Control.Monad.State

--------------------------------------------------------------------------------

newtype Visa = Visa { visaSession :: Maybe ViSession } deriving (Eq, Show)

type VisaError = (ViStatus, String)
type VisaResult = Either VisaError

instance Error VisaError where
    noMsg = (0, "")
    strMsg msg = (0, msg)

newtype VisaT m a = VisaT
    { unVisaT :: ErrorT VisaError (StateT Visa m) a
    } deriving
        ( Monad
        , MonadError VisaError
        , MonadState Visa
        , MonadIO)

instance MonadTrans VisaT where
    lift = lift

type VisaIO a = VisaT IO a

--------------------------------------------------------------------------------

runVisaT :: (Monad m) => VisaT m a -> m (VisaResult a, Visa)
runVisaT visaT = runStateT (runErrorT (unVisaT visaT)) (Visa Nothing)

execVisaT :: (Monad m) => VisaT m a -> m (VisaResult a)
execVisaT visaT = runVisaT visaT >>= return . fst

execVisaT' :: (Monad m) => VisaT m a -> m ()
execVisaT' visaT = execVisaT visaT >> return ()

runWithVisaT :: (Monad m) => VisaT m a -> Visa -> m (VisaResult a, Visa)
runWithVisaT visaT vi = runStateT (runErrorT (unVisaT visaT)) vi

execWithVisaT :: (Monad m) => VisaT m a -> Visa -> m (VisaResult a)
execWithVisaT visaT vi = runWithVisaT visaT vi >>= return . fst

execWithVisaT' :: (Monad m) => VisaT m a -> Visa -> m ()
execWithVisaT' visaT vi = execWithVisaT visaT vi >> return ()

--------------------------------------------------------------------------------

runVisaIO :: VisaIO a -> IO (VisaResult a, Visa)
runVisaIO = runVisaT

execVisaIO :: VisaIO a -> IO (VisaResult a)
execVisaIO = execVisaT

execVisaIO' :: VisaIO a -> IO ()
execVisaIO' visa = execVisaIO visa >> return ()

runWithVisaIO :: VisaIO a -> Visa -> IO (VisaResult a, Visa)
runWithVisaIO = runWithVisaT

execWithVisaIO :: VisaIO a -> Visa -> IO (VisaResult a)
execWithVisaIO = execWithVisaT

execWithVisaIO' :: VisaIO a -> Visa -> IO ()
execWithVisaIO' visa vi = execWithVisaIO visa vi >> return ()
