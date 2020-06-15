let reverse str =
  let len = String.length str in
  let res = Bytes.make len ' ' in
  String.iteri (fun idx c -> Bytes.set res (len - idx - 1) c) str ;
  Bytes.to_string res


let solve () =
  let input = read_line () in
  let nums =
    List.map int_of_string (List.map reverse (String.split_on_char ' ' input))
  in
  let answer = List.fold_left max 0 nums in
  print_int answer


let () = solve ()
