module Main (main) where

import Lib

main :: IO ()
main = do
    d <- loadDataset "day1.txt"
    putStrLn d
