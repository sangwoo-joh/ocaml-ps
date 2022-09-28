exception Invalid

let calc p =
  let stack = ref [] in
  let score = ref 1 in
  let answer = ref 0 in
  let score_of c = if c = '(' || c = ')' then 2 else 3 in
  let _open c () =
    score := !score * score_of c;
    stack := c :: !stack
  in
  let _close c i () =
    let opened = if c = ')' then '(' else '[' in
    if !stack = [] || List.hd !stack <> opened then raise Invalid;
    if i > 0 && String.get p (i - 1) = opened then answer := !answer + !score;
    stack := List.tl !stack;
    score := !score / score_of c
  in
  let check i c =
    match c with
    | '(' | '[' -> _open c ()
    | ')' | ']' -> _close c i ()
    | _ -> raise Invalid
  in
  try
    String.iteri check p;
    if !stack <> [] then 0 else !answer
  with Invalid -> 0


let () =
  let parens = read_line () in
  print_int (calc parens)
