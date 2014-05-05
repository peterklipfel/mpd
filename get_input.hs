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
  pressKey bits
    where 
      getbits = BG.runGet $ BBG.runBitGet parseMidi

oressKey :: (Integral a) => (a, a, a) -> IO()
oressKey (a, 48, c) = runRobot $ tap _Tilde
oressKey (a, 49, c) = runRobot $ tap _Space
oressKey (a, 50, c) = runRobot $ tap _Tilde
oressKey x = return ()

parseMidi = 
  (,,)
    <$> BBG.getWord8 8
    <*> BBG.getWord8 8
    <*> BBG.getWord8 8
