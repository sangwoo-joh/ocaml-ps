let input () =
  let line = read_line () in
  String.split_on_char ' ' line

let rev_string s =
  String.to_seq s |> List.of_seq |> List.rev |> List.to_seq |> String.of_seq

let solve l =
  let answer = List.map rev_string l in
  List.iter (fun s -> print_string s; print_string " ") answer

let () =
  let tc = read_int () in
  for _ = 1 to tc do
    let words = input () in
    solve words
  done
