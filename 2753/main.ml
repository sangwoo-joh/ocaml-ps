let leap_year year =
  if (year mod 4 = 0 && year mod 100 != 0) || year mod 400 = 0 then 1 else 0

let solve () = Scanf.scanf "%d" (fun year -> print_int (leap_year year))

let () = solve ()
