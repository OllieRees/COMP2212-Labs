{
module Tokens where
}

%wrapper "posn" 
$digit = 0-9     
-- digits 
$alpha = [a-zA-Z]    
-- alphabetic characters

tokens :-
$white+       ; 
  "--".*        ; 
  let           { (\p s -> TokenLet p) } 
  in            { (\p s -> TokenIn p) }
  $digit+       { (\p s -> TokenInt p (read s)) } 
  \=            { (\p s -> TokenEq p) }
  \+            { (\p s -> TokenPlus p) }
  \-            { (\p s -> TokenMinus p) }
  \*            { (\p s -> TokenTimes p) }
  \/            { (\p s -> TokenDiv p) }
  \^            { (\p s -> TokenPow p) }
  \(            { (\p s -> TokenLParen p) }
  \)            { (\p s -> TokenRParen p) }
  $alpha [$alpha $digit \_ \’]*   { (\p s -> TokenVar p s) } 

{ 
-- Each action has type :: AlexPosn -> String -> Token 
-- The token type: 

data Token = 
  TokenLet    { posn :: AlexPosn }                      | 
  TokenIn     { posn :: AlexPosn }                      | 
  TokenInt    { posn :: AlexPosn, valInt :: Int }       |
  TokenVar    { posn ::  AlexPosn, valStr :: String }   | 
  TokenEq     { posn :: AlexPosn }                      |
  TokenPlus   { posn :: AlexPosn }                      |
  TokenMinus  { posn :: AlexPosn }                      |
  TokenTimes  { posn :: AlexPosn }                      |
  TokenDiv    { posn :: AlexPosn }                      |
  TokenPow    { posn :: AlexPosn }                      |
  TokenLParen { posn :: AlexPosn }                      |
  TokenRParen { posn :: AlexPosn }
  deriving (Eq,Show)

-- Return line and column of given token
tokenPosn :: Token -> (Int, Int)
tokenPosn t = (l, c)
  where (AlexPn _ l c) = posn t
}
