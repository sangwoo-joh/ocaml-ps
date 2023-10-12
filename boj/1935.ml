let input () =
  let vars = read_int () in
  let exp = read_line () in
  let var_map = Hashtbl.create vars in
  for i = 1 to vars do
    let value = read_int () |> float_of_int in
    let var = i + 65 - 1 |> Char.chr in
    Hashtbl.add var_map var value
  done;
  exp, var_map
;;

let ops = [ '+', ( +. ); '-', ( -. ); '*', ( *. ); '/', ( /. ) ]

let eval exp var_map =
  let stack : float Stack.t = Stack.create () in
  let eval char =
    match char with
    | 'A' .. 'Z' ->
      let value = Hashtbl.find var_map char in
      Stack.push value stack
    | ('+' | '-' | '*' | '/') as op ->
      let v1 = Stack.pop stack in
      let v0 = Stack.pop stack in
      let operator = List.assoc op ops in
      let result = operator v0 v1 in
      Stack.push result stack
    | _ -> failwith "invalid char"
  in
  String.iter eval exp;
  Stack.pop stack
;;

let () =
  let exp, var_map = input () in
  let result = eval exp var_map in
  Printf.printf "%.2f" result
;;
