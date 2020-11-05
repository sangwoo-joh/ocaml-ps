let () =
  let total, m = Scanf.scanf "%d %d " (fun t m -> (t, m)) in
  let rec read_input acc =
    try
      let n = Scanf.scanf "%d " (fun d -> d) in
      read_input (n :: acc)
    with End_of_file -> acc
  in
  let cards = read_input [] in
  assert (total = List.length cards);
  let nearest_sum = ref 0 in
  List.iteri
    (fun i1 c1 ->
      List.iteri
        (fun i2 c2 ->
          if i1 != i2 then
            List.iteri
              (fun i3 c3 ->
                if i3 != i1 && i3 != i2 then
                  let sum = c1 + c2 + c3 in
                  if !nearest_sum <= sum && sum <= m then nearest_sum := sum)
              cards)
        cards)
    cards;
  Printf.printf "%d\n" !nearest_sum
