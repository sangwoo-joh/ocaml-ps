type 'a tree = Node of ('a tree * 'a * 'a tree) | Nil

type order = Preorder | Inorder | Postorder

let rec traverse ~order ~visit tree =
  let traverse' = traverse ~order ~visit in
  match tree with
  | Nil -> ()
  | Node (left, value, right) -> (
    match order with
    | Preorder -> visit value ; traverse' left ; traverse' right
    | Inorder -> traverse' left ; visit value ; traverse' right
    | Postorder -> traverse' left ; traverse' right ; visit value )

let to_idx ch = int_of_char ch - int_of_char 'A'

let construct_tree node_info =
  let rec construct c =
    match node_info.(to_idx c) with
    | '.', '.' -> Node (Nil, c, Nil)
    | l, '.' -> Node (construct l, c, Nil)
    | '.', r -> Node (Nil, c, construct r)
    | l, r -> Node (construct l, c, construct r)
  in
  construct 'A'

let read_input total () =
  let node_info = Array.make 26 (' ', ' ') in
  for i = 0 to total - 1 do
    Scanf.scanf "%c %c %c\n" (fun root left right ->
        node_info.(to_idx root) <- (left, right) )
  done ;
  node_info

let solve () =
  let visit c = print_char c in
  Scanf.scanf "%d\n" (fun total ->
      let node_info = read_input total () in
      let tree = construct_tree node_info in
      traverse ~order:Preorder ~visit tree ;
      print_newline () ;
      traverse ~order:Inorder ~visit tree ;
      print_newline () ;
      traverse ~order:Postorder ~visit tree ;
      print_newline () )

let () = solve ()
