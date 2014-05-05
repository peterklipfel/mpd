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
  --print bits
    where 
      getbits = BG.runGet $ BBG.runBitGet parseMidi

pressKey :: (Integral a) => (a, a, a) -> IO()
pressKey (144, 36, c) = runRobot $ tap _A
pressKey (144, 37, c) = runRobot $ tap _B
pressKey (144, 38, c) = runRobot $ tap _C
pressKey (144, 39, c) = runRobot $ tap _D
pressKey (144, 40, c) = runRobot $ tap _E
pressKey (144, 41, c) = runRobot $ tap _F
pressKey (144, 42, c) = runRobot $ tap _G
pressKey (144, 43, c) = runRobot $ tap _H
pressKey (144, 44, c) = runRobot $ tap _I
pressKey (144, 45, c) = runRobot $ tap _J
pressKey (144, 46, c) = runRobot $ tap _K
pressKey (144, 47, c) = runRobot $ tap _L
pressKey (144, 48, c) = runRobot $ tap _M
pressKey (144, 49, c) = runRobot $ tap _N
pressKey (144, 50, c) = runRobot $ tap _O
pressKey (144, 51, c) = runRobot $ tap _P
pressKey x144= return ()

parseMidi = 
  (,,)
    <$> BBG.getWord8 8
    <*> BBG.getWord8 8
    <*> BBG.getWord8 8
