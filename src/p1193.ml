let line x = (x + 1) * x / 2

let hit bot top = Format.printf "%d/%d\n" bot top

exception Early_exit

let find x =
  let l = ref 1 in
  ( try
      while true do
        if x <= line !l then raise Early_exit;
        incr l
      done
    with Early_exit -> () );
  let kth = x - line (!l - 1) in
  let bot, top = (1 + (kth - 1), !l - (kth - 1)) in
  if !l mod 2 = 0 then hit bot top else hit top bot


let () = Scanf.scanf "%d" (fun x -> find x)
