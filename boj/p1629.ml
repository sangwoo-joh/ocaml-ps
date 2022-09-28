let power base exp rem =
  let rec fast_power base exp acc_even acc_odd =
    if exp = 0 then 1
    else if exp = 1 then acc_even * acc_odd mod rem
    else if exp mod 2 = 0 then
      fast_power base (exp / 2) (acc_even * acc_even mod rem) acc_odd
    else fast_power base (exp - 1) acc_even (acc_even * acc_odd mod rem)
  in
  fast_power base exp base 1


let () =
  Scanf.scanf "%d %d %d " (fun base exp rem ->
      Printf.printf "%d" (power base exp rem))
