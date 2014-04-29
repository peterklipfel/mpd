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
  runRobot $ pressKey bits
    where 
      getbits = BG.runGet $ BBG.runBitGet parseMidi

pressKey :: (Integral a) => (a, a, a) -> Robot()
pressKey (a, 48, c) = tap _Tilde
pressKey (a, 49, c) = tap _Space
pressKey (a, 50, c) = tap _Tilde
pressKey x = tap _Space

parseMidi = 
  (,,)
    <$> BBG.getWord8 8
    <*> BBG.getWord8 8
    <*> BBG.getWord8 8
