let join a b =
  match (a, b) with
  | a, [] | [], a -> a
  | _, _ -> List.map2 (fun a b -> String.concat "" [ a; b ]) a b


let combine block = List.fold_left join [] block

let map_combine blocks = List.flatten (List.map combine blocks)

let rec empty n =
  if n = 3 then [ "   "; "   "; "   " ]
  else
    let e = empty (n / 3) in
    map_combine [ [ e; e; e ]; [ e; e; e ]; [ e; e; e ] ]


let rec stars n =
  if n = 3 then [ "***"; "* *"; "***" ]
  else
    let next = n / 3 in
    let s = stars next in
    let e = empty next in
    map_combine [ [ s; s; s ]; [ s; e; s ]; [ s; s; s ] ]


let print_block blocks = List.iter (Printf.printf "%s\n") blocks

let print_star n = print_block (stars n)
