-- zipL zips up two lists of equal length into a list of list. Why it isn't a list of pairs is beyond me.
zipL :: [a] -> [a] -> [[a]]
zipL xs ys
  | length xs /= length ys = error "List arguments must be of the same length"
  | otherwise = [[x, y] | (x, y) <- zip xs ys]

-- Inverse of zipL
unzipL :: [[a]] -> ([a], [a])
unzipL xss 
  | any (\xs -> length xs /= 2) xss = error "One of the lists in the argument has a length that isn't equal to 2"
  | otherwise = (map (!! 0) xss, map (!! 1) xss)
