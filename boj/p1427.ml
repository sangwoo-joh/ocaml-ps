let () =
  let input = read_line () in
  List.iter
    (fun c -> print_char c)
    (List.sort (fun x y -> compare y x) (List.of_seq (String.to_seq input)))
