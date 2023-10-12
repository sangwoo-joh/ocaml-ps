let () =
  Scanf.scanf "%d %d %d" (fun p1 p2 p3 ->
    let reward =
      if p1 = p2 && p2 = p3
      then 10000 + (p1 * 1000)
      else if p1 = p2
      then 1000 + (p1 * 100)
      else if p2 = p3
      then 1000 + (p2 * 100)
      else if p1 = p3
      then 1000 + (p1 * 100)
      else max p1 (max p2 p3) * 100
    in
    Printf.printf "%d\n" reward)
;;
