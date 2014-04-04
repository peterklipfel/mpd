import Control.Monad  
import Data.Char
import Data.Binary as B
import qualified Data.Binary.Get as BG
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Put
import qualified Data.Binary.Bits.Get as BBG

import System.IO
  
main = forever $ do
  contents <- BL.getContents
  print $ BG.runGet getMidi contents

data Midi = Midi
  { first  :: !(Word8, Word8)
  , second :: !(Word8, Word8)
  } deriving (Show)


getMidi :: Get Midi
getMidi = do
  bytes  <- BG.getWord16le
  bytes2 <- BG.getWord16le
  let blah1 = parse4by4 bytes
  let blah2 = parse4by4 bytes2
  return $! Midi blah1 blah2

parse4by4 :: BBG.BitGet (Word8, Word8)
parse4by4 = do
   bits <- BBG.getWord8 4
   more <- BBG.getWord8 4
   return (bits,more)
