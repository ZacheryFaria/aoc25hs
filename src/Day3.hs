module Day3
  ( solve,
  )
where

import Lib

-- >>> intoNumber '1' '3'
-- 13
intoNumber :: Char -> Char -> Int
intoNumber a b = Lib.charToInt a * 10 + Lib.charToInt b

--- >>> largestNumber' "234234234234278" '0' 0
-- 78
largestNumber' :: String -> Char -> Int -> Int
largestNumber' (hd : tl) prevLargest best = largestNumber' tl (max hd prevLargest) (max best (intoNumber prevLargest hd))
largestNumber' [] _ best = best

largestNumber :: String -> Int
largestNumber n = largestNumber' n '0' 0

solve inputData = sum $ map largestNumber parsedData
  where
    parsedData = lines inputData
