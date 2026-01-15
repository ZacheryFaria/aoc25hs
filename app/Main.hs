module Main (main) where

import Day1
import Day2
import Day3
import Day4
import Lib

solve_day1 = do
  d <- loadDataset "day1_full.txt"
  let result = Day1.solve $ lines d
   in putStrLn $ show result

solve_day2 = do
  d <- loadDataset "day2.txt"
  let result = Day2.solve d
   in putStrLn $ show result

solve_day3 = do
  d <- loadDataset "day3_full.txt"
  let result = Day3.solve d
   in putStrLn $ show result

solve_day4 = do
  d <- loadDataset "day4_full.txt"
  let result = Day4.solve d
   in putStrLn $ show result

main :: IO ()
main = do
  solve_day4
