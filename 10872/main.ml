let rec fac n = if n = 0 then 1 else n * fac (n - 1)

let () = Scanf.scanf "%d" (fun n -> print_int (fac n))
