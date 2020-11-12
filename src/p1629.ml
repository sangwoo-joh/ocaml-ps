let power base exp rem =
  let rec fast_power base exp a1 a2 =
    if exp = 0 then 1
    else if exp = 1 then a1 * a2 mod rem
    else if exp mod 2 = 0 then fast_power base (exp / 2) (a1 * a1 mod rem) a2
    else fast_power base (exp - 1) a1 (a1 * a2 mod rem)
  in
  fast_power base exp base 1


let () =
  Scanf.scanf "%d %d %d " (fun base exp rem ->
      Printf.printf "%d" (power base exp rem))
