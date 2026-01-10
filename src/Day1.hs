module Day1 
(solve,
Direction,
 Command,
) where

import Prelude hiding (Left, Right)


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

calcAnswer :: Int -> Int -> Int
calcAnswer acc 0 = acc + 1
calcAnswer acc _ = acc

applyCommand :: (Int, Int) -> Command -> (Int, Int)
applyCommand (result, prev) cmd = ((calcAnswer result nextResult), nextResult) 
    where nextResult = normalize $ applyCommand' cmd prev

-- accepts raw string (split into new lines). must do the rest
solve :: [String] -> Int
solve raw = do
    let commands = map parseRow raw
        (result, _) = foldl applyCommand (0, 50) commands
        in result

