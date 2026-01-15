module Day4
  ( solve,
  )
where

getCoords rows cols = concat [[(row, col) | col <- [0 .. cols - 1]] | row <- [0 .. rows - 1]]

-- >>> neighbors 0 5 6 6
-- [(1,4),(1,5),(0,4)]
getNeighbors row col rowLimit colLimit = filter checkOption options
  where
    checkOption (r, c) = r >= 0 && c >= 0 && r < rowLimit && c < colLimit
    options =
      [ (row + 1, col + 1),
        (row - 1, col + 1),
        (row + 1, col - 1),
        (row - 1, col - 1),
        (row + 1, col),
        (row - 1, col),
        (row, col + 1),
        (row, col - 1)
      ]

getCell dataset row col = value
  where
    rowValue = dataset !! row
    value = rowValue !! col

isPaper dataset r c = getCell dataset r c == '@'

countNeighbors dataset rowLimit colLimit (row, col) = sum $ map hasPaper neighbors
  where
    neighbors = getNeighbors row col rowLimit colLimit
    hasPaper (r, c) = if isPaper dataset r c then 1 else 0

solve dataset = length $ filter (< 4) neighborCounts
  where
    parsedDataset = lines dataset
    rowLimit = length parsedDataset
    colLimit = length $ head parsedDataset
    coords = getCoords rowLimit colLimit
    paperCoords = filter (\(r, c) -> isPaper parsedDataset r c) coords
    neighborCounts = map (countNeighbors parsedDataset rowLimit colLimit) paperCoords
