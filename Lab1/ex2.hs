zipL :: [a] -> [a] -> [[a]]
zipL [] [] = []
zipL [] ys = [[y] | y <- ys]
zipL xs [] = [[x] | x <- xs]
zipL (x:xs) (y:ys) = [x, y]:zipL xs ys

-- Not really possible since it doesn't know which list was originally longer (the left or the right). We can only assume.
unzipL :: [[a]] -> ([a], [a])
unzipL xss = ([head xs | xs <- xss], [xs !! 1 | xs <- xss, length xs == 2])
