let rec is_doom_number x =
  if x mod 1000 = 666
  then true
  else if x < 1000
  then false
  else is_doom_number (x / 10)
;;

let doom_number nth =
  let rec aux kth acc =
    if is_doom_number acc then (
      if kth = nth then acc
      else aux (kth + 1) (acc + 1)
    ) else aux kth (acc + 1)
  in
  aux 1 666
;;

let () = Scanf.scanf "%d " (fun x -> Printf.printf "%d" (doom_number x))
