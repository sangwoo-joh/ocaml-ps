module IntSet = Set.Make (Int)

let () =
  let numbers = ref IntSet.empty in
  Scanf.scanf "%d " (fun total ->
      for _ = 1 to total do
        Scanf.scanf "%d " (fun n -> numbers := IntSet.add n !numbers)
      done);
  Scanf.scanf "%d " (fun total ->
      for _ = 1 to total do
        Scanf.scanf "%d " (fun n ->
            if IntSet.mem n !numbers then Printf.printf "1\n"
            else Printf.printf "0\n")
      done)
