let () =
  let maybe_bytes = read_int () in
  let rec loop n =
    if n = 0
    then ()
    else (
      Printf.printf "long ";
      loop (n - 1))
  in
  ignore (loop (maybe_bytes / 4));
  Printf.printf "int\n"
;;
