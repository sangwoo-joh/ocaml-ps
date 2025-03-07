type t =
  | NonPerfect
  | Perfect of int list

let get_perfect n =
  let rec factors p q acc =
    if p = q
    then List.sort Int.compare acc
    else if p mod q = 0
    then factors p (q + 1) (q :: acc)
    else factors p (q + 1) acc
  in
  let factors = factors n 1 [] in
  let s = List.fold_left ( + ) 0 factors in
  if s = n then Perfect factors else NonPerfect
;;

exception Exit

let rec judge () =
  let x = Scanf.scanf "%d " Fun.id in
  if x = -1 then raise Exit;
  (match get_perfect x with
   | NonPerfect -> Printf.printf "%d is NOT perfect.\n" x
   | Perfect factors ->
     let sum = List.map string_of_int factors |> String.concat " + " in
     Printf.printf "%d = %s\n" x sum);
  judge ()
;;

let () =
  try judge () with
  | Exit -> ()
;;
