let count_words str =
  let str = String.trim str in
  let spaces = ref 0 in
  let count_space ch = if ch = ' ' then incr spaces in
  String.iter count_space str ;
  if String.length str = 0 then 0 else !spaces + 1


let solve () =
  let input = read_line () in
  print_int (count_words input)


let () = solve ()
