let sum num_str =
  let acc = ref 0 in
  String.iter (fun ch -> acc := !acc + (Char.code ch - Char.code '0')) num_str ;
  !acc

let solve () = Scanf.scanf "%d\n%s" (fun _ num_str -> print_int (sum num_str))

let () = solve ()
