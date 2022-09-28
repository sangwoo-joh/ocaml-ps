let lower_bound cmp arr x =
  let rec aux lo hi =
    if lo = hi then lo
    else
      let mid = lo + ((hi - lo) / 2) in
      if cmp arr.(mid) x < 0 then aux (mid + 1) hi else aux lo mid
  in
  aux 0 (Array.length arr)


let upper_bound cmp arr x =
  let rec aux lo hi =
    if lo = hi then lo
    else
      let mid = lo + ((hi - lo) / 2) in
      if cmp arr.(mid) x > 0 then aux lo mid else aux (mid + 1) hi
  in
  aux 0 (Array.length arr)


let id x = x

let () =
  let card_total = Scanf.scanf "%d " id in
  let card_arr = Array.make card_total 0 in
  for i = 0 to card_total - 1 do
    Scanf.scanf "%d " (fun c -> card_arr.(i) <- c)
  done;
  Array.fast_sort compare card_arr;
  Scanf.scanf "%d " (fun total ->
      for _ = 1 to total do
        Scanf.scanf "%d " (fun c ->
            let lb = lower_bound compare card_arr c in
            let ub = upper_bound compare card_arr c in
            Printf.printf "%d " (ub - lb))
      done)
