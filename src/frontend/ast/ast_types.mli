(* Stores the line and position of the token *)
type location = Lexing.position

(* Abstract type for identifiers *)
module type ID = sig
    type t
    val of_string : string -> t
    val to_string : t -> string
    val ( = ) : t -> t -> bool
  end

(* Defines expression types *)
type type_expressions = 
    | TEInt
    | TEClass   of Class_name.t
    | TEVoid
    | TEBool