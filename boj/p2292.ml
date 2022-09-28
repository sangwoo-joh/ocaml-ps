let seq n = (3 * n * n) + (3 * n) + 1

let max_n = 19000

let gen () =
  let arr = Array.make max_n 0 in
  for i = 0 to max_n - 1 do
    arr.(i) <- seq i
  done;
  arr


exception Early_exit

let answer k =
  let sequence = gen () in
  let ans = ref 0 in
  while true do
    if k <= sequence.(!ans) then (
      Format.printf "%d\n" (!ans + 1);
      raise Early_exit );
    incr ans
  done;
  ()


let () = Scanf.scanf "%d" (fun n -> try answer n with Early_exit -> ())
