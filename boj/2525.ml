let () =
  Scanf.scanf "%d %d %d" (fun hour min take ->
    let min = min + take in
    let hour = hour + (min / 60) in
    let min = min mod 60 in
    Printf.printf "%d %d\n" (hour mod 24) min)
;;
