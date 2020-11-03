let id x = x

let () =
  let k = Scanf.scanf "%d " id in
  let stack = Stack.create () in
  for _ = 1 to k do
    let num = Scanf.scanf "%d " id in
    if num = 0 then ignore (Stack.pop_opt stack) else Stack.push num stack
  done;
  let sum = Stack.fold ( + ) 0 stack in
  Printf.printf "%d\n" sum
