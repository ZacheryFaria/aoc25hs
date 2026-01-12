module Main (main) where

import Lib
import Day1
import Day2

solve_day1 = do 
    d <- loadDataset "day1_full.txt"
    let result = Day1.solve $ lines d
        in putStrLn $ show result

solve_day2 = do
    d <- loadDataset "day2.txt"
    let result = Day2.solve d
        in putStrLn $ show result



main :: IO ()
main = do
    solve_day2
