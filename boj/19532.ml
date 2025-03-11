exception QED

let solve a b c d e f =
  let brute_force () =
    for x = -999 to 999 do
      for y = -999 to 999 do
        if (a * x) + (b * y) = c && (d * x) + (e * y) = f
        then (
          Printf.printf "%d %d" x y;
          raise QED)
      done
    done
  in
  try brute_force () with
  | QED -> ()
;;

let () = Scanf.scanf "%d %d %d %d %d %d " solve
