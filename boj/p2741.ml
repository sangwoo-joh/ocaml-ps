let rec put cur n =
  if cur > n then ()
  else (
    Printf.printf "%d\n" cur ;
    put (cur + 1) n )


let () = Scanf.scanf "%d" (fun n -> put 1 n)
