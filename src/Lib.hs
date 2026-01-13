module Lib
  ( loadDataset,
    charToInt,
    wordsWhen,
    wordSplit,
  )
where

import System.IO

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of
  "" -> []
  s' -> w : wordsWhen p s''
    where
      (w, s'') = break p s'

wordSplit :: Char -> String -> [String]
wordSplit c s = wordsWhen (== c) s

charToInt :: Char -> Int
charToInt c = fromEnum c - fromEnum '0'

loadDataset :: String -> IO String
loadDataset file = withFile file ReadMode $ \handler -> hGetContents' handler
