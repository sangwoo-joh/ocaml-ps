let id x = x

let () =
  let t = Scanf.scanf "%d " id in
  let stack = Stack.create () in
  for _ = 1 to t do
    Stack.clear stack;
    let str = Scanf.scanf "%s " id in
    let chars = String.to_seq str in
    try
      Seq.iter
        (fun c -> if c = '(' then Stack.push () stack else Stack.pop stack)
        chars;
      Printf.printf "%s\n" (if Stack.is_empty stack then "YES" else "NO")
    with Stack.Empty -> Printf.printf "NO\n"
  done
