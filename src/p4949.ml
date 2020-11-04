exception Not_balanced

let check str =
  let stack = Stack.create () in
  let chars = String.to_seq str in
  let check_aux c =
    match c with
    | '(' -> Stack.push c stack
    | '[' -> Stack.push c stack
    | ')' -> (
        match Stack.pop_opt stack with
        | Some '(' -> ()
        | _ -> raise Not_balanced )
    | ']' -> (
        match Stack.pop_opt stack with
        | Some '[' -> ()
        | _ -> raise Not_balanced )
    | _ -> ()
  in
  try
    Seq.iter check_aux chars;
    Printf.printf "%s\n" (if Stack.is_empty stack then "yes" else "no")
  with Not_balanced -> Printf.printf "no\n"


let () =
  let rec solve () =
    let str = read_line () in
    if str = "." then ()
    else (
      check str;
      solve () )
  in
  try solve () with End_of_file -> ()
