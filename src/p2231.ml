let bunhae_hap x =
  let sum = ref x in
  let x = ref x in
  while !x > 0 do
    sum := !sum + (!x mod 10);
    x := !x / 10
  done;
  !sum


exception Early_found of int

let () =
  let num = read_int () in
  let constructor =
    try
      for n = 1 to num do
        if bunhae_hap n = num then raise (Early_found n)
      done;
      0
    with Early_found n -> n
  in
  Printf.printf "%d\n" constructor
