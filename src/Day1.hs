module Day1
  ( solve,
    normalize,
    calcAnswerPart2,
    calcPart2Amount,
    Direction,
    Command,
  )
where

import Debug.Trace (trace, traceShowId)
import Prelude hiding (Left, Right)

-- >>> triple 5
triple l = l * 3

data Direction = Left | Right deriving (Show)

data Command = Command Direction Int deriving (Show)

parseDirection :: Char -> Direction
parseDirection 'L' = Left
parseDirection 'R' = Right
parseDirection _ = error "Invalid direction"

parseRow :: String -> Command
parseRow row =
  let dir = (parseDirection $ head row)
      amount = (read (tail row)) :: Int
   in (Command dir amount)

normalize :: Int -> Int
normalize val = val `mod` 100

applyCommand' :: Command -> Int -> Int
applyCommand' (Command Left amt) acc = acc - amt
applyCommand' (Command Right amt) acc = acc + amt

-- calcAnswer :: Int -> Int -> Int
-- calcAnswer acc 0 = acc + 1
-- calcAnswer acc _ = acc

-- calcPart2Amount value previous
calcPart2Amount :: Int -> Int -> Int
calcPart2Amount 0 _ = 1
calcPart2Amount value 0 = (abs value `div` 100)
calcPart2Amount value _ = if value > 0 then value `div` 100 else ((abs value `div` 100) + 1)

calcAnswerPart2 acc value prev = acc + (calcPart2Amount value prev)

-- applyCommand :: (Int, Int) -> Command -> (Int, Int)
-- applyCommand (result, prev) cmd = ((calcAnswer result nextResult), nextResult)
--     where nextResult = normalize $ applyCommand' cmd prev

applyCommandPart2 (result, prev) cmd = ((trace ("prev=" ++ show prev ++ ",command=" ++ show cmd ++ ",answer=" ++ show answer ++ ",nextResult=" ++ show nextResult ++ ",normal=" ++ show normalizedResult) answer), normalizedResult)
  where
    nextResult = applyCommand' cmd prev
    normalizedResult = normalize nextResult
    answer = (calcAnswerPart2 result nextResult prev)

-- accepts raw string (split into new lines). must do the rest
solve :: [String] -> Int
solve raw = do
  let commands = map parseRow raw
      (result, _) = foldl applyCommandPart2 (0, 50) commands
   in result
