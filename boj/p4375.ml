let solve n =
  let rec aux digits num =
    if num mod n = 0 then digits
    else aux (digits + 1) ((num * 10 + 1) mod n)
  in
  aux 1 1


let rec main () =
  try
    let n = Scanf.scanf "%d " (fun i -> i) in
    Printf.printf "%d\n" (solve n);
    main ()
  with End_of_file -> ()


let () = main ()
