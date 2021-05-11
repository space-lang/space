(* Header helper functions (exposed in OCaml source code) *)
{
open Lexing
open Parser

exception SyntaxError of string

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    {
      pos with pos_bol = lexbuf.lex_curr_pos;
      pos_lnum = pos.pos_lnum + 1
    }
}

(* Defining helper regexes *)
let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']

let int = '-'? digit+
let id = (alpha) (alpha|digit|'_')*
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

 (* Pattern Matching tokens *)
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
  | "const"     { CONST }
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
  | "put"       { PRINT } 
  | "ret"       { RETURN }
  | whitespace  { read_token lexbuf }
  | "--"        { read_single_line_comment lexbuf }
  | "-{-"       { read_multi_line_comment lexbuf } 
  | int         { INT (int_of_string (Lexing.lexeme lexbuf))}
  | id          { ID (Lexing.lexeme lexbuf) }
  | '"'         { read_string (Buffer.create 17) lexbuf }
  | newline     { next_line lexbuf; read_token lexbuf }
  | eof         { EOF }
  | _           { raise (SyntaxError ("Lexer - Illegal character: " ^ Lexing.lexeme lexbuf)) }

(* Reading single line comments *)
and read_single_line_comment = parse
  | newline     { next_line lexbuf; read_token lexbuf }
  | eof         { EOF }
  | _           { read_single_line_comment lexbuf }

(* Reading multi line comments *)
and read_multi_line_comment = parse
  | "-}-"       { read_token lexbuf }
  | newline     { next_line lexbuf; read_multi_line_comment lexbuf }
  | eof         { raise (SyntaxError ("Lexer - Unexpected EOF - please terminate your comment.")) }
  | _           { read_multi_line_comment lexbuf }

(* Reading strings *)
and read_string buf = parse
  | '"'         { STRING (Buffer.contents buf) }
  | '\\' '/'    { Buffer.add_char buf '/';    read_string buf lexbuf }
  | '\\' '\\'   { Buffer.add_char buf '\\';   read_string buf lexbuf }
  | '\\' 'b'    { Buffer.add_char buf '\b';   read_string buf lexbuf }
  | '\\' 'f'    { Buffer.add_char buf '\012'; read_string buf lexbuf }
  | '\\' 'n'    { Buffer.add_char buf '\n';   read_string buf lexbuf }
  | '\\' 'r'    { Buffer.add_char buf '\r';   read_string buf lexbuf }
  | '\\' 't'    { Buffer.add_char buf '\t';   read_string buf lexbuf }
  | [^ '"' '\\']+ { Buffer.add_string buf (Lexing.lexeme lexbuf); read_string buf lexbuf }
  | _           { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof         { raise (SyntaxError ("String is not terminated")) }