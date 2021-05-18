let check_identifier_assignable class_defns identifier env loc = 
    let open Result in
    match identifier with
        | Parsed_ast.Variable x ->
            if x = Var_nameof_string "this" then
                Error
                    (Error.of_string
                        (Fmt.str "%s Type error - Assigning expr to 'this'.@." (string_of_loc loc)))
                    else Ok ()
        | Parsed_ast.ObjField (obj_name, field_name) ->
             get_obj_class_defn obj_name env class_defns loc
            >>= fun class_defn ->
            get_class_field field_name class_defn loc
            >>= fun (TField (modifier, _, _, _)) ->
            if modifier = MConst then
                Error
                    (Error.of_string
                        (Fmt.str "%s Type error - Assigning expr to a const field.@."
                            (string_of_loc loc)))
            else Ok ()