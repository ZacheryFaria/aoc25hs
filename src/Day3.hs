module Day3
  ( solve,
  )
where

import Lib

-- >>> intoNumber ['1', '3', '4']
-- 134
intoNumber :: [Char] -> Int
intoNumber c = foldl inc 0 c
  where
    inc acc v = acc * 10 + Lib.charToInt v

-- >>> variants ['1', '2', '3']
-- ["23","13","12"]
variants :: [a] -> [[a]]
variants enum = map (\i -> deleteNth i enum) [0 .. len]
  where
    len = length enum - 1

-- given a list of digits ['1', '2', '3'] and a new digit '4', find the largest number you could make if you subbed out anything in the input array with the new number
-- >>> checkGreater ['5', '2', '3'] '4'
-- "534"
findGreatest :: [Char] -> Char -> [Char]
findGreatest arr c = foldl compareGreatest arr $ variants arr
  where
    compareGreatest acc nextOption =
      let candidate = nextOption ++ [c]
          accInt = intoNumber acc
          candidateInt = intoNumber candidate
       in if accInt > candidateInt then acc else candidate

largestNumberNew :: Int -> [Char] -> Int
largestNumberNew size n = intoNumber $ foldl findGreatest start rest
  where
    (start, rest) = splitAt size n

-- use 2 for part 1, 12 for part 12
solve inputData = sum $ map (largestNumberNew 12) parsedData
  where
    parsedData = lines inputData
