let id x = x

exception No_VPS

let () =
  let t = Scanf.scanf "%d " id in
  let stack = Stack.create () in
  for _ = 1 to t do
    Stack.clear stack;
    let str = Scanf.scanf "%s " id in
    let chars = String.to_seqi str in
    try
      Seq.iter
        (fun (i, c) ->
          if c = '(' then Stack.push c stack
          else
            match Stack.pop_opt stack with
            | Some p -> ()
            | None -> raise No_VPS)
        chars;
      Printf.printf "%s\n" (if Stack.is_empty stack then "YES" else "NO")
    with No_VPS -> Printf.printf "NO\n"
  done
