let rec put n =
  if n = 0 then ()
  else (
    Printf.printf "%d\n" n ;
    put (n - 1) )


let () = Scanf.scanf "%d" (fun n -> put n)
