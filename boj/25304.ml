(* NOTE: if we use `read_int` and `print_endline` for this problem, we will get runtime error for huge tc. *)
let () =
  let total_cost = Scanf.scanf "%d " (fun x -> x) in
  let n = Scanf.scanf "%d " (fun x -> x) in
  let receipt = ref [] in
  for i = 1 to n do
    let price, quantity = Scanf.scanf "%d %d " (fun x y -> x, y) in
    receipt := (price, quantity) :: !receipt
  done;
  let sumup l = List.fold_left (fun acc (p, q) -> acc + (p * q)) 0 l in
  if sumup !receipt = total_cost
  then Printf.printf "Yes"
  else Printf.printf "No"
;;
