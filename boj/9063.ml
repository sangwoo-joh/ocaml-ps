module IntSet = Set.Make (Int)

let xs = ref IntSet.empty
let ys = ref IntSet.empty

let scan () =
  Scanf.scanf "%d %d " (fun x y ->
    xs := IntSet.add x !xs;
    ys := IntSet.add y !ys)
;;

let () =
  let n = Scanf.scanf "%d " Fun.id in
  for _ = 1 to n do
    scan ()
  done;
  let area =
    (IntSet.max_elt !xs - IntSet.min_elt !xs)
    * (IntSet.max_elt !ys - IntSet.min_elt !ys)
  in
  Printf.printf "%d" area
;;
