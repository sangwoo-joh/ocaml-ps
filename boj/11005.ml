let to_other_system num =
  match num with
  | _ when 0 <= num && num <= 9 -> Char.code '0' + num |> Char.chr
  | _ when 10 <= num && num <= 35 -> Char.code 'A' - 10 + num |> Char.chr
  | _ -> failwith "no"
;;

let () =
  let n, b = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let res = ref [] in
  let n = ref n in
  while !n > 0 do
    let t = !n mod b |> to_other_system in
    res := t :: !res;
    n := !n / b
  done;
  !res |> List.to_seq |> String.of_seq |> print_endline
;;
