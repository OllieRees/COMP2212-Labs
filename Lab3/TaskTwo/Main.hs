import Grammar
import Tokens
import System.Environment(getArgs)

-- Compilation functions
readProgram :: IO String
readProgram = do
  fs <- getArgs
  case length fs of
    0 -> error "No arguments provided"
    _ -> readFile (head fs)

getTokens :: IO [Token]
getTokens = do
  c <- readProgram
  return (alexScanTokens c)

main = do
  ts <- getTokens
  print (parseCalc ts)

-- Interpreter functions
readProgramI :: String -> IO String
readProgramI s = readFile s

getTokensI :: String -> [Token]
getTokensI s = alexScanTokens s

parseTokens :: [Token] -> Exp
parseTokens ts = parseCalc ts

parse :: String -> IO Exp
parse filepath = do 
  p <- readProgramI filepath
  return (parseTokens (getTokensI p))
