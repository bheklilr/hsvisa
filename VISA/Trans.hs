{-# OPTIONS_GHC -fno-warn-orphans       #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeSynonymInstances       #-}
{-# LANGUAGE FlexibleInstances          #-}
-- | The internal Monad Transformer stack for the VISA library and associated
-- functions for running a VISA action.  It also defines a convenience type
-- 'VisaIO' which just applies the 'VisaT' transformer to the 'IO' monad.
module VISA.Trans
    ( Visa(..)
    , VisaError, VisaResult

    , VisaT
    , runVisaT, execVisaT, execVisaT'
    , runWithVisaT, execWithVisaT, execWithVisaT'

    , VisaIO
    , runVisaIO, execVisaIO, execVisaIO'
    , runWithVisaIO, execWithVisaIO, execWithVisaIO'

    , MonadIO
    , liftIO
    , throwError, catchError
    , get, put
    ) where


import VISA.Driver.Types

import Control.Monad.Error hiding (void)
import Control.Monad.State hiding (void)

--------------------------------------------------------------------------------

-- | The VISA session object.  Contains, among other things, the handle to the VISA session.
-- This type should never be manually constructed.
data Visa = Visa
    { visaSession :: Maybe ViSession
    , visaRsrcMgr :: Maybe ViSession
    } deriving (Eq, Show)

-- | A VisaError is the error code and the error message
type VisaError = (ViStatus, String)

-- | A VisaResult is either an error or a value
type VisaResult = Either VisaError

-- | A basic 'Error' implementation for 'VisaError'
instance Error VisaError where
    noMsg = (0, "")
    strMsg msg = (0, msg)

-- | The monad transformer used to encapsulate VISA communication.  It's built
-- from the 'StateT' and 'ErrorT' transformers.
newtype VisaT m a = VisaT
    { unVisaT :: ErrorT VisaError (StateT Visa m) a
    } deriving
        ( Functor
        , Monad
        , MonadIO
        , MonadFix
        , MonadPlus
        , MonadState Visa
        , MonadError VisaError
        )

instance MonadTrans VisaT where
    lift = lift

-- | A nicer type alias for simple VISA applications.
type VisaIO a = VisaT IO a

--------------------------------------------------------------------------------

void :: Monad m => m a -> m ()
void action = do
    action
    return ()

-- | The most general run function, it runs a 'VisaT' action with the given initial
-- state and returns a full 'VisaResult' and the final 'Visa' session object.
runWithVisaT :: (MonadIO io) => VisaT io a -> Visa -> io (VisaResult a, Visa)
runWithVisaT visaT = runStateT (runErrorT (unVisaT visaT))

-- | The same as 'runWithVisaT', but drops the final 'Visa' session object.
execWithVisaT :: (MonadIO io) => VisaT io a -> Visa -> io (VisaResult a)
execWithVisaT visaT vi = liftM fst $ runWithVisaT visaT vi

-- | The same as 'execWithVisaT', but doesn't return anything.
execWithVisaT' :: (MonadIO io) => VisaT io a -> Visa -> io ()
execWithVisaT' visaT vi = void $ execWithVisaT visaT vi

-- | Runs a 'VisaT' action with the default starting state.  A session will be
-- generated on demand.
runVisaT :: (MonadIO io) => VisaT io a -> io (VisaResult a, Visa)
runVisaT visaT = runWithVisaT visaT (Visa Nothing Nothing)

-- | The same as 'runVisaT', but drops the final 'Visa' session object.
execVisaT :: (MonadIO io) => VisaT io a -> io (VisaResult a)
execVisaT visaT = liftM fst $ runVisaT visaT

-- | The same as 'execVisaT', but doesn't return anything.
execVisaT' :: (MonadIO io) => VisaT io a -> io ()
execVisaT' visaT = void $ execVisaT visaT

--------------------------------------------------------------------------------

-- | Runs a 'VisaIO' action.
runVisaIO :: VisaIO a -> IO (VisaResult a, Visa)
runVisaIO = runVisaT

-- | The same as 'runVisaIO', but drops the final 'Visa' session object.
execVisaIO :: VisaIO a -> IO (VisaResult a)
execVisaIO = execVisaT

-- | The same as 'execVisaIO', but doesn't return anything.
execVisaIO' :: VisaIO a -> IO ()
execVisaIO' = execVisaT'

-- | Runs a 'VisaIO' action with an initial 'Visa' session.
runWithVisaIO :: VisaIO a -> Visa -> IO (VisaResult a, Visa)
runWithVisaIO = runWithVisaT

-- | The same as 'runWithVisaIO', but drops the final 'Visa' session object.
execWithVisaIO :: VisaIO a -> Visa -> IO (VisaResult a)
execWithVisaIO = execWithVisaT

-- | The same as 'execWithVisaIO', but doesn't return anything.
execWithVisaIO' :: VisaIO a -> Visa -> IO ()
execWithVisaIO' = execWithVisaT'
