let () =
  Scanf.scanf "%d %d %d " (fun a b v ->
      let perday = a - b in
      let goal = v - b - 1 in
      Printf.printf "%d" ((goal / perday) + 1))
