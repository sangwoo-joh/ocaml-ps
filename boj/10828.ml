let () =
  let num_cmd = read_int () in
  let stack : int Stack.t = Stack.create () in
  for _ = 1 to num_cmd do
    let cmds = String.split_on_char ' ' (read_line ()) in
    if List.length cmds > 1 then
      (* push x *)
      let x = int_of_string (List.nth cmds 1) in
      Stack.push x stack
    else
      match List.hd cmds with
      | "pop" -> (
          match Stack.pop_opt stack with
          | Some top -> Printf.printf "%d\n" top
          | None -> Printf.printf "-1\n" )
      | "size" -> Printf.printf "%d\n" (Stack.length stack)
      | "empty" -> Printf.printf "%d\n" (if Stack.is_empty stack then 1 else 0)
      | "top" -> (
          match Stack.top_opt stack with
          | Some top -> Printf.printf "%d\n" top
          | None -> Printf.printf "-1\n" )
      | _ -> assert false
  done
