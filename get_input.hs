import Control.Monad  
import Control.Applicative
import Data.Binary.Put
import System.IO
import Test.Robot
import qualified Data.Binary.Get as BG
import qualified Data.ByteString.Lazy as BL
import qualified Data.Binary.Bits.Get as BBG
import Data.Word

data Midi = Midi Event KeyCode deriving Show
data Event = KeyUp | KeyDown | Aftertouch | Unknown Word8 deriving Show

type KeyCode = Word8

identify :: (Integral a) => [a] -> Maybe Key
identify [36] = Just _A
identify _    = Nothing


pressKey :: Midi -> IO()
pressKey (Midi KeyUp a) = maybe (return ()) (runRobot . tap) (identify [a])
pressKey _              = return ()


determineEvent :: Word8 -> Event
determineEvent 144 = KeyDown
determineEvent 128 = KeyUp
determineEvent 208 = Aftertouch
determineEvent a   = Unknown a

parseMidi :: BBG.BitGet Midi
parseMidi = do
	word1 <- BBG.getWord8 8
	word2 <- BBG.getWord8 8
	_     <- BBG.getWord8 8
	return $ Midi (determineEvent word1) word2

main :: IO()
main = forever $ do
  bits <- fmap getbits $ BL.getContents 
  pressKey bits
  print bits
    where 
      getbits = BG.runGet $ BBG.runBitGet parseMidi

