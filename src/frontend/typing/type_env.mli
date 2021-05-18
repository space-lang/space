type type_binding = Var_name.t * type_expression
type type_env     = type_binding list

(** A bunch of getter methods used in type-checking the core language *)
val get_var_type : Var_name.t -> type_env -> loc -> type_expr Or_error.t