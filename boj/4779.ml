let rec power x = function
  | 0 -> 1
  | 1 -> x
  | n ->
    let half = power x (n / 2) in
    half * half * if n mod 2 = 0 then 1 else x
;;

let rec cantor buf l r =
  if l >= r || r - l = 1
  then ()
  else (
    let one_third, two_thirds = (r - l) / 3, (r - l) * 2 / 3 in
    let s, e = l + one_third, l + two_thirds in
    for i = s to e - 1 do
      Bytes.set buf i ' '
    done;
    cantor buf l s;
    cantor buf e r)
;;

let rec solve () =
  let n = read_int () in
  let size = power 3 n in
  let buf = Bytes.make size '-' in
  cantor buf 0 size;
  Printf.printf "%s\n" (Bytes.to_string buf);
  solve ()
;;

let () =
  try solve () with
  | _ -> ()
;;
