let rec a_plus_b i =
  if i = 0 then ()
  else (
    Scanf.scanf " %d %d" (fun a b -> print_endline (string_of_int (a + b))) ;
    a_plus_b (i - 1) )


let solve () = Scanf.scanf "%d" (fun n -> a_plus_b n)

let () = solve ()
