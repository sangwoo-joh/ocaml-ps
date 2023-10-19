let () =
  Scanf.scanf "%d %d %d %d %d %d" (fun k q l b n p ->
    Printf.printf
      "%d %d %d %d %d %d"
      (1 - k)
      (1 - q)
      (2 - l)
      (2 - b)
      (2 - n)
      (8 - p))
;;
