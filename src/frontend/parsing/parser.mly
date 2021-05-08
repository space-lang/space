/* Parser specification */

/* Token definitions */
%token  LPAREN          /* ( */
%token  RPAREN          /* ) */
%token  LBRACE          /* { */
%token  RBRACE          /* } */
%token  LANGLE          /* < */
%token  RANGLE          /* > */
%token  COMMA           /* , */
%token  DOT             /* . */
%token  COLON           /* : */
%token  SEMICOLON       /* ; */
%token  EQUAL           /* = */
%token  PLUS            /* + */
%token  MINUS           /* - */
%token  MULT            /* * */
%token  DIV             /* / */
%token  REM             /* % */
%token  AND             /* && */
%token  OR              /* || */
%token  EXMARK          /* ! */
%token  COLONEQ         /* := */
%token  LET             /* let */
%token  NEW             /* new */
%token  CONST           /* const */
%token  VAR             /* var */
%token  FUNCTION        /* fun */
%token  CLASS           /* class */
%token  TYPE_INT        /* int */
%token  TYPE_BOOL       /* bool */
%token  TYPE_VOID       /* void */
%token  TRUE            /* true */
%token  FALSE           /* false */
%token  IF              /* if */
%token  ELSE            /* else */
%token  FOR             /* for */
%token  WHILE           /* while */
%token  MAIN            /* main */
%token  PRINT           /* print */
%token  RETURN          /* ret */
%token  EOF             /* -{- not a char/string -}- */