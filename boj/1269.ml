module IntSet = Set.Make (Int)

let () =
  let _ = read_line () in
  let load () =
    read_line ()
    |> String.split_on_char ' '
    |> List.map int_of_string
    |> List.fold_left (fun acc x -> IntSet.add x acc) IntSet.empty
  in
  let a = load () in
  let b = load () in
  Printf.printf
    "%d"
    ((IntSet.diff a b |> IntSet.cardinal) + (IntSet.diff b a |> IntSet.cardinal))
;;
