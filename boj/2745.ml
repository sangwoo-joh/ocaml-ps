let pow x n = float_of_int x ** float_of_int n |> int_of_float

let get_num c =
  match c with
  | '0' .. '9' -> Char.code c - 48
  | 'A' .. 'Z' -> Char.code c - 65 + 10
;;

let () =
  let n, b = Scanf.scanf "%s %d" (fun x y -> x, y) in
  let n10 = ref 0 in
  String.iteri
    (fun i c -> n10 := !n10 + (get_num c * pow b (String.length n - 1 - i)))
    n;
  Printf.printf "%d" !n10
;;
