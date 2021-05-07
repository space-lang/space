rule read_token = parse 
  | "("         { LPAREN }
  | ")"         { RPAREN }
  | "{"         { LBRACE }
  | "}"         { RBRACE }
  | ","         { COMMA }
  | "."         { DOT }
  | ":"         { COLON }
  | ";"         { SEMICOLON }
  | "="         { EQUAL }
  | "+"         { PLUS }
  | "-"         { MINUS }
  | "*"         { MULT } 
  | "/"         { DIV }
  | "%"         { REM }
  | "<"         { LANGLE }
  | ">"         { RANGLE }
  | "&&"        { AND }
  | "||"        { OR }
  | "!"         { EXCLAMATION_MARK }
  | ":="        { COLONEQ }
  | "let"       { LET }
  | "new"       { NEW }
  | "const"     {CONST }
  | "var"       { VAR }
  | "fun"       { FUNCTION }
  | "class"     { CLASS }
  | "int"       { TYPE_INT }
  | "bool"      { TYPE_BOOL } 
  | "void"      { TYPE_VOID }
  | "true"      { TRUE }
  | "false"     { FALSE }
  | "while"     { WHILE }
  | "if"        { IF }
  | "else"      { ELSE }
  | "for"       { FOR }
  | "main"      { MAIN }
  | "print"     {PRINT } 
  | whitespace  { read_token lexbuf }
  | "--"        { read_single_line_comment lexbuf }
  | "-{-"       { read_multi_line_comment lexbuf } 
  | int         { INT (int_of_string (Lexing.lexeme lexbuf))}
  | id          { ID (Lexing.lexeme lexbuf) }
  | '"'         { read_string (Buffer.create 17) lexbuf }
  | newline     { next_line lexbuf; read_token lexbuf }
  | eof         { EOF }
  | _           {raise (SyntaxError ("Lexer - Illegal character: " ^ Lexing.lexeme lexbuf)) }
