let input () =
  let _n, k =
    read_line ()
    |> String.split_on_char ' '
    |> List.map int_of_string
    |> fun l -> List.hd l, List.hd (List.tl l)
  in
  let scores =
    read_line () |> String.split_on_char ' ' |> List.map int_of_string
  in
  scores, k
;;

let cutline scores k =
  let scores = List.sort (fun a b -> b - a) scores in
  let rec cut scores k =
    if k = 1 then List.hd scores else cut (List.tl scores) (k - 1)
  in
  cut scores k
;;

let main () =
  let scores, k = input () in
  print_int (cutline scores k)
;;

let () = main ()
