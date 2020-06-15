let () =
  Scanf.scanf "%d" (fun n ->
      for i = 1 to n do
        Scanf.scanf " %d %d" (fun a b ->
            Printf.printf "Case #%d: %d\n" i (a + b))
      done)
