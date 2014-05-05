import Control.Monad  
import Control.Applicative
import Data.Binary.Put
import System.IO
import Test.Robot
import qualified Data.Binary.Get as BG
import qualified Data.ByteString.Lazy as BL
import qualified Data.Binary.Bits.Get as BBG

  
main = forever $ do
  bits <- fmap getbits $ BL.getContents 
  getKey bits
    where 
      getbits = BG.runGet $ BBG.runBitGet parseMidi

getKey :: (Integral a) => (a, a, a) -> IO()
getKey (a, 48, c) = runRobot $ tap _Tilde
getKey (a, 49, c) = runRobot $ tap _Space
getKey (a, 50, c) = runRobot $ tap _Tilde
getKey x = return ()

--pressKey :: Maybe(Robot()) -> IO()
--pressKey Just x  = runRobot x
--pressKey Nothing = ()

parseMidi = 
  (,,)
    <$> BBG.getWord8 8
    <*> BBG.getWord8 8
    <*> BBG.getWord8 8
