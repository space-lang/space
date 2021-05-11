type expression = 
    | Integer       of location * int
    | Constructor   of location * Class_name.t * type_expression option * constructor_arg list
    | Assign        of location * identifier * expression
    | If            of location * expression * block_expression * block_expression

and block_expression = Block of location * expression list

type class_define =
    | TClass of Class_name.t 
        * field_define  list
        * method_define list