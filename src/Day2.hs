
module Day2
(
splitInputData,
filterRow,
chunkStr,
solve
) where
import Lib

allEqual :: [String] -> Bool
allEqual (hd:tl) = all (==hd) tl
allEqual [] = True

chunkStr :: String -> Int -> [String]
chunkStr str width
    | length str == width = [str]
    | otherwise = let (hd, tl) = splitAt width str
                    in hd : chunkStr tl width


isInvalidPart1 :: String -> Bool
isInvalidPart1 x = if length x `mod` 2 == 1 
    then False 
    else allEqual $ chunkStr x half
    where half = length x `div` 2


-- checks if a particular number (represented as a string) is considered invalid according to the current width
-- it does this by first splitting (chunkStr) it by the current width, if possible (if not possible, then it's NOT invalid)
-- then we pass the result of that into (allEqual)
isInvalidPart2' :: String -> Int -> Bool
isInvalidPart2' str width =
    if length str `mod` width /= 0 
        then False
        else allEqual $ chunkStr str width 


isInvalidPart2 :: String -> Bool
isInvalidPart2 str = 
    let half = length str `div` 2
        in any (isInvalidPart2' str) [1.. half] 
        


-- swap out the function here to swap between part1 and part2
filterInvalidIds :: [String] -> [String]
filterInvalidIds rng = filter isInvalidPart2 rng


filterRow :: (Int, Int) -> [Int]
filterRow (start, end) = map read $ filterInvalidIds $ map show [start..end]

solveRow :: (Int, Int) -> Int
solveRow row = sum $ filterRow row


splitRow :: String -> (Int, Int)
splitRow s = (read a, read b) where (a:b:_) = Lib.wordSplit '-' s


splitInputData :: String -> [(Int, Int)]
splitInputData s = map splitRow arr 
    where arr = Lib.wordSplit ',' s


solve :: String -> Int
solve input = 
    let splitted = splitInputData input
        invalidIds = map solveRow splitted
        in sum invalidIds
