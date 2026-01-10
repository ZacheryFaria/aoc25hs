module Main (main) where

import Lib
import Day1

main :: IO ()
main = do
    d <- loadDataset "day1_full.txt"
    let result = solve $ lines d
        in putStrLn $ show result
