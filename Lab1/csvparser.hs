%name readCSV
%tokentype { Token }
%error { parseError }

%token
  ','   { }
  int   { }
  '\n'  { }

%%

DataFile : 
  | DataLine

DataLine : 
  | DataValue

DataValue : 
  |
