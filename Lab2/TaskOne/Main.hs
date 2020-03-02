import MDL

import System.Environment(getArgs)

readProgram :: IO String
readProgram = do
  fs <- getArgs
  case length fs of
    0 -> error "No arguments provided"
    _ -> readFile (head fs)

main = do
  c <- readProgram
  print (alexScanTokens c)
