let solve () =
  Scanf.scanf "%d %d %d" (fun a b c ->
      let nums = [a; b; c] in
      let sorted = List.sort Pervasives.compare nums in
      print_int (List.nth sorted 1))


let () = solve ()
