{ 
module MDL where 
import MDLToken
}

%name parseMDL 
%tokentype { Token } 
%error { parseError }
%token 
    right         { TokenRotateRight _ } 
    left          { TokenRotateLeft _ } 
    forward       { TokenForward _ } 
    obstacle      { TokenObstacle _ } 
    if            { TokenIf _ } 
    then          { TokenThen _ } 
    else          { TokenElse _ } 
    boolVal       { TokenMDLBoolVal _ $$ } 
    boolOp        { TokenMDLBoolOp _ $$ } 
    int           { TokenMDLVar _ $$ }
    done          { TokenMDLEnd _ }

%left else
%%

MDL : forward int MDL                             { Forward $2 $3 } 
    | right MDL                                   { RotateRight $2 }
    | left MDL                                    { RotateLeft $2 }
    | obstacle int MDL                            { Obstacle $2 $3 }
    | if Condition then MDL else MDL              { If $2 $4 $6 }
    | done                                        { End }


Condition : boolVal                               { BoolVal $1 }
          | int boolOp int                        { BoolOperation $2 $1 $3 }
          | obstacle int                          { Obstacle $2 Done }

{ 
parseError :: [Token] -> a
parseError ts 
  | null ts = error "Last line isn't a complete expression." -- Parses tokens fine. Tokens don't form a complete expression though, e.g. let var = 3...
  | otherwise = error ("Parse error with token " ++ (show (head ts)) ++ " at line " ++ (show line) ++ " and column " ++ (show col) ++ ".")
    where (line, col) = tokenPosn (head ts)

data MDL = Forward Int MDL
         | RotateRight MDL
         | RotateLeft MDL
         | Obstacle Int MDL
         | If MDL MDL MDL
         | BoolVal Bool
         | BoolOperation String Int Int
         | End
         deriving Show 
} 
