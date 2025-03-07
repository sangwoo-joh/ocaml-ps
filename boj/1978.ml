let is_prime = Array.make 1001 true

let sieve_eratosthenes () =
  is_prime.(0) <- false;
  is_prime.(1) <- false;
  for x = 2 to 1000 do
    if is_prime.(x)
    then (
      let order = ref 2 in
      let f = ref (x * !order) in
      while !f <= 1000 do
        is_prime.(!f) <- false;
        incr order;
        f := x * !order
      done)
  done
;;

let () =
  sieve_eratosthenes ();
  let _ = read_line () in
  let ns = read_line () |> String.split_on_char ' ' |> List.map int_of_string in
  let is_prime x = is_prime.(x) in
  List.filter is_prime ns |> List.length |> Printf.printf "%d"
;;
