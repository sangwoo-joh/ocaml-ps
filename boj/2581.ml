let n = 10_001
let is_prime = Array.make n true

let sieve_eratosthenes () =
  is_prime.(0) <- false;
  is_prime.(1) <- false;
  for x = 2 to n - 1 do
    if is_prime.(x)
    then (
      let order = ref 2 in
      let f = ref (x * !order) in
      while !f <= n - 1 do
        is_prime.(!f) <- false;
        incr order;
        f := x * !order
      done)
  done
;;

let rec sosusum m n min acc =
  if m > n
  then min, acc
  else if is_prime.(m)
  then sosusum (m + 1) n (if m < min then m else min) (acc + m)
  else sosusum (m + 1) n min acc
;;

let () =
  sieve_eratosthenes ();
  let m, n = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let min, sum = sosusum m n (n + 1) 0 in
  if sum = 0 then Printf.printf "-1" else Printf.printf "%d\n%d" sum min
;;
