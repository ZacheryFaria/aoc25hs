module Lib
  ( loadDataset,
    charToInt,
    deleteNth,
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

deleteNth :: Int -> [a] -> [a]
deleteNth n xs = before ++ afterTail
  where
    (before, after) = splitAt n xs
    afterTail = drop 1 after

loadDataset :: String -> IO String
loadDataset file = withFile file ReadMode $ \handler -> hGetContents' handler

setAt :: Int -> a -> [a] -> [a]
setAt i newVal list = take i list ++ [newVal] ++ drop (i + 1) list

-- >>> setAt2 1 1 'd' ["000", "111"]
-- ["000","1d1"]
setAt2 :: Int -> Int -> a -> [[a]] -> [[a]]
setAt2 row col newVal list = setAt row updatedRow list
  where
    (rowVal : _) = drop row list
    updatedRow = setAt col newVal rowVal
