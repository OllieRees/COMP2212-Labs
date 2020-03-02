{
module MDL where
import System.Environment(getArgs)
}

%wrapper "posn"

$digit=0-9
$alpha=[a-zA-Z]
$boolOp = [== != \< \> \<= \>=]

@boolVal = True | False

tokens :-

  Right                                                       {(\p s -> RotateLeft p)}
  Left                                                        {(\p s -> RotateRight p)}
  Forward                                                     {(\p s -> Forward p)}
  Obstacle                                                    {(\p s -> Obstacle p)}
  If                                                          {(\p s -> If p)}
  then                                                        {(\p s -> Then p)}
  else                                                        {(\p s -> Else p)}
  @boolVal                                                    {(\p s -> MDLBoolVal p (convStr2Bool s))}
  $boolOp                                                     {(\p s -> MDLBoolOp p s)}
  $digit+                                                     {(\p s -> MDLVar p (read s))}
  $white+                                                     ;
  $alpha+                                                     ;

{

-- Token type
data Token =
        RotateLeft {posn :: AlexPosn}                     |
        RotateRight {posn :: AlexPosn}                    |
        Forward {posn :: AlexPosn}                        |
        Obstacle {posn :: AlexPosn}                       |
        If {posn :: AlexPosn}                             |
        Else {posn :: AlexPosn}                           |
        Then {posn :: AlexPosn}                           |
        MDLBoolVal {posn :: AlexPosn, bool :: Bool}       |
        MDLBoolOp {posn :: AlexPosn, op :: String}        |
        MDLVar {posn :: AlexPosn, val :: Int}
        deriving(Eq, Show)

convStr2Bool :: String -> Bool
convStr2Bool "True" = True
convStr2Bool "False" = False
}
