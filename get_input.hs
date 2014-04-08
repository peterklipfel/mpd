import Control.Monad  
import Data.Char
import Data.Binary as B
import qualified Data.Binary.Get as BG
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Put
import qualified Data.Binary.Bits.Get as BBG

import Control.Applicative

import System.IO
  
main = forever $ do
  contents <- BL.getContents
  let bits = BG.runGet (BBG.runBitGet parse4by4) contents
  print bits

--data Midi = Midi
--  { first  :: [Word8]
--  , second :: [Word8]
--  } deriving (Show)


--getMidi :: Get Midi
--getMidi = do
--  first  <- BBG.getWord8
--  second <- BBG.getWord8
--  return $! Midi first second

parse4by4 = 
  (,,,)
    <$> BBG.getWord32be 8
    <*> BBG.getWord32be 8
    <*> BBG.getWord32be 8
    <*> BBG.getWord32be 8
