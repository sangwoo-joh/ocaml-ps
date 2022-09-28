let score s =
  let os =
    List.map
      (fun x -> String.length x)
      (String.split_on_char 'X' (String.trim s))
  in
  let osums = List.map (fun x -> x * (x + 1) / 2) os in
  List.fold_left ( + ) 0 osums


let () =
  Scanf.scanf "%d " (fun tc ->
      for i = 1 to tc do
        Scanf.scanf "%s\n" (fun s -> Format.printf "%d\n" (score s))
      done)
