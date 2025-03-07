let () =
  let n, k = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let kk = ref k in
  let q = ref 0 in
  for x = 1 to n do
    if n mod x = 0 then (
      decr kk;
      q := x;
    );
    if !kk = 0 then (
      Printf.printf "%d" !q;
      exit 0;
    )
  done;
  Printf.printf "0"
