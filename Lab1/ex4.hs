import Data.List (intercalate)
import Data.List.Split (splitOn)

multiZipL :: [[a]] -> [[a]]
multiZipL [] = []
multiZipL xss = [head xs | xs <- xss, (length xs) > 0]:multiZipL [tail xs | xs <- xss, (length xs) > 1]

removeBlanks :: String -> String
removeBlanks s = filter (/= ' ') s

readCSV :: String -> [[Int]]
readCSV s = multiZipL (map (map (\x -> read x :: Int)) (map (map removeBlanks) (map (splitOn ",") (lines s))))

writeCSV :: [[Int]] -> String
writeCSV nss = [c | c <- (intercalate "\n" [show ns | ns <- nss]), c /= '[', c /= ']']

multiZipF :: FilePath -> IO ()
multiZipF path = do
  contents <- readFile path
  writeFile "output.txt" (writeCSV (readCSV contents))
