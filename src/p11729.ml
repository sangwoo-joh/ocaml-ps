module P = Printf

let rec hanoi n from via t =
  if n = 1 then P.printf "%d %d\n" from t
  else (
    hanoi (n - 1) from t via;
    P.printf "%d %d\n" from t;
    hanoi (n - 1) via from t )


let hanoi_cnt n =
  let rec aux n acc = if n = 1 then acc else aux (n - 1) ((acc * 2) + 1) in
  aux n 1


let () =
  Scanf.scanf "%d" (fun n ->
      P.printf "%d\n" (hanoi_cnt n);
      hanoi n 1 2 3)
