let count_croatia str =
  let bytes = Bytes.of_string str in
  let raw_len = String.length str in
  let len = ref 0 in
  let idx = ref 0 in

  let lookahead c =
    if !idx + 1 < raw_len && Bytes.get bytes (!idx + 1) = c then (
      incr len;
      idx := !idx + 2 )
    else (
      incr len;
      incr idx )
  in

  while !idx < raw_len do
    match Bytes.get bytes !idx with
    | 'c' ->
        if
          !idx + 1 < raw_len
          && ( Bytes.get bytes (!idx + 1) = '='
             || Bytes.get bytes (!idx + 1) = '-' )
        then (
          incr len;
          idx := !idx + 2 )
        else (
          incr idx;
          incr len )
    | 'd' ->
        if !idx + 1 < raw_len && Bytes.get bytes (!idx + 1) = '-' then (
          incr len;
          idx := !idx + 2 )
        else if
          !idx + 2 < raw_len
          && Bytes.get bytes (!idx + 1) = 'z'
          && Bytes.get bytes (!idx + 2) = '='
        then (
          incr len;
          idx := !idx + 3 )
        else (
          incr len;
          incr idx )
    | 'l' -> lookahead 'j'
    | 'n' -> lookahead 'j'
    | 's' -> lookahead '='
    | 'z' -> lookahead '='
    | _ ->
        incr len;
        incr idx
  done;
  !len


let () = Scanf.scanf "%s" (fun s -> print_int (count_croatia s))
