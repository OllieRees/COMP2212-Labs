multiZipL :: [[a]] -> [[a]]
multiZipL [] = []
multiZipL xss = [head xs | xs <- xss, (length xs) > 0]:multiZipL [tail xs | xs <- xss, (length xs) > 1]
