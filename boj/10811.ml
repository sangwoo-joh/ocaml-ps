let reverse arr from _to =
  let from, _to = ref from, ref _to in
  while !from < !_to do
    let t = arr.(!from) in
    arr.(!from) <- arr.(!_to);
    arr.(!_to) <- t;
    incr from;
    decr _to
  done
;;

let () =
  let n, m = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let arr = Array.init n succ in
  for _ = 1 to m do
    let from, _to = Scanf.scanf "%d %d " (fun x y -> x, y) in
    reverse arr (from - 1) (_to - 1)
  done;
  Array.iter (fun x -> Printf.printf "%d " x) arr
;;
