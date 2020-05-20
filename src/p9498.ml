let () =
  Scanf.scanf "%d" (fun score ->
      let p = print_string in
      match score / 10 with 10 | 9 -> p "A" | 8 -> p "B" | 7 -> p "C" | 6 -> p "D" | _ -> p "F")
