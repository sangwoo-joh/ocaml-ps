let factorise x =
  let target = ref x in
  let primes = ref [] in
  for q = 2 to x do
    while !target <> 1 && !target mod q = 0 do
      primes := q :: !primes;
      target := !target / q
    done
  done;
  List.rev !primes
;;

let () =
  let x = read_int () in
  List.iter (fun x -> Printf.printf "%d\n" x) (factorise x)
;;
