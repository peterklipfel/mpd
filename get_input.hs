import Control.Monad  
import Data.Char
import Data.Binary as B
import Data.Binary.Get
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL

import System.IO
  
main = forever $ do
  contents <- BL.getContents
  print $ runGet getMidi contents

data Midi = Midi
  {
    bytes :: !Word16
  } deriving (Show)

getMidi :: Get Midi
getMidi = do
  bytes <- getWord16le
  return $! Midi bytes
