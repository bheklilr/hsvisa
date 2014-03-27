{-# LANGUAGE BangPatterns   #-}
module VISA
    ( module VISA.Trans

    , scanForInstruments
    , openSimple
    , writeVisa
    , readVisa
    , queryVisa
    , closeSesn
    ) where


import           VISA.Driver.Types
import           VISA.Driver.VppConsts
import qualified VISA.IO                as Vi
import           VISA.Trans

import Control.Monad (forM)
import Control.Concurrent (threadDelay)

-- | A monadic version of Control.Monad.void since I don't want to add the Functor constraint
voidM :: Monad m => m a -> m ()
voidM m = do
    _ <- m
    return ()

--------------------------------------------------------------------------------

scanForInstruments :: MonadIO io => VisaT io [String]
scanForInstruments = do
    (fl, cnt, first) <- Vi.findRsrc "?*"
    !rest <- forM [2..cnt] $ \_ -> Vi.findNext fl
    return $ first : rest

openSimple :: MonadIO io => String -> VisaT io ()
openSimple rsrc = do
    Vi.open rsrc viNull viTmoImmediate
    Vi.setAttribute viAttrTmoValue 1000
    Vi.setAttribute viAttrTermcharEn 0
    Vi.setAttribute viAttrSendEndEn 1

writeVisa :: MonadIO io => String -> VisaT io ()
writeVisa msg = voidM $ Vi.writeVi msg

readVisa :: MonadIO io => VisaT io String
readVisa = do
    let maxCnt = 20480
    let loop = do
        str <- Vi.readVi maxCnt
        if length str < fromEnum maxCnt
            then return str
            else do
                rest <- loop
                return $ str ++ rest
    loop

queryVisa :: MonadIO io => String -> VisaT io String
queryVisa msg = writeVisa msg >> readVisa

closeSesn :: MonadIO io => VisaT io ()
closeSesn = do
    rm <- Vi.getRsrcMgr
    Vi.close rm


test :: VisaIO ()
test = do
    openSimple "ASRL13::INSTR"
    liftIO $ threadDelay $ 2000 * 1000
    writeVisa "arduino::id\r\n"
    resp <- readVisa
    liftIO $ putStrLn resp
    closeSesn

test2 :: VisaIO ()
test2 = do
    openSimple "ASRL13::INSTR"
    liftIO $ threadDelay $ 2000 * 1000
    writeVisa "arduino::i2c::version\n"
    readVisa >>= liftIO . putStr
    writeVisa "arduino::switch::version\n"
    readVisa >>= liftIO . putStr
    closeSesn
