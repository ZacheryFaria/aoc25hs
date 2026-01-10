module Lib
    ( loadDataset
    ) where

import System.IO

loadDataset :: String -> IO String
loadDataset file = withFile file ReadMode $ \handler -> hGetContents' handler