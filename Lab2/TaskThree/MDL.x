{
module MDLToken where
import System.Environment(getArgs)
}

%wrapper "posn"

$digit=0-9
$alpha=[a-zA-Z]
$boolOp = [== != \< \> \<= \>=]

@boolVal = True | False

tokens :-

  Right                                                             {(\p s -> TokenRotateRight p)}
  Left                                                              {(\p s -> TokenRotateLeft p)}
  Forward                                                           {(\p s -> TokenForward p)}
  Obstacle                                                          {(\p s -> TokenObstacle p)}
  If                                                                {(\p s -> TokenIf p)}
  then                                                              {(\p s -> TokenThen p)}
  else                                                              {(\p s -> TokenElse p)}
  @boolVal                                                          {(\p s -> TokenMDLBoolVal p (convStr2Bool s))}
  $boolOp                                                           {(\p s -> TokenMDLBoolOp p s)}
  $digit+                                                           {(\p s -> TokenMDLVar p (read s))}
  Done                                                              {(\p s -> TokenMDLEnd p)}
  $white+                                                           ;
  $alpha+                                                           ;

{
-- Token type
data Token =
        TokenRotateRight {posn :: AlexPosn}                     |
        TokenRotateLeft {posn :: AlexPosn}                      |
        TokenForward {posn :: AlexPosn}                         |
        TokenObstacle {posn :: AlexPosn}                        |
        TokenIf {posn :: AlexPosn}                              |
        TokenElse {posn :: AlexPosn}                            |
        TokenThen {posn :: AlexPosn}                            |
        TokenMDLBoolVal {posn :: AlexPosn, bool :: Bool}        |
        TokenMDLBoolOp {posn :: AlexPosn, op :: String}         |
        TokenMDLVar {posn :: AlexPosn, val :: Int}              |
        TokenMDLEnd {posn :: AlexPosn}
        deriving(Eq, Show)

convStr2Bool :: String -> Bool
convStr2Bool "True" = True
convStr2Bool "False" = False

tokenPosn :: Token -> (Int, Int)
tokenPosn t = (line, column)
  where (AlexPn _ line column) = posn t
}
