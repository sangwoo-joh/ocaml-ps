module IntQueue = struct
  exception Empty

  type cell = Nil | Cons of { content : int; mutable next : cell }

  type t = { mutable length : int; mutable first : cell; mutable last : cell }

  let create () = { length = 0; first = Nil; last = Nil }

  let clear q =
    q.length <- 0;
    q.first <- Nil;
    q.last <- Nil


  let add x q =
    let cell = Cons { content = x; next = Nil } in
    match q.last with
    | Nil ->
        q.length <- 1;
        q.first <- cell;
        q.last <- cell
    | Cons last ->
        q.length <- q.length + 1;
        last.next <- cell;
        q.last <- cell


  let push = add

  let peek q =
    match q.first with
    | Nil -> raise Empty
    | Cons { content } -> content


  let peek_opt q =
    match q.first with
    | Nil -> None
    | Cons { content } -> Some content


  let top = peek

  let take q =
    match q.first with
    | Nil -> raise Empty
    | Cons { content; next = Nil } ->
        clear q;
        content
    | Cons { content; next } ->
        q.length <- q.length - 1;
        q.first <- next;
        content


  let take_opt q =
    match q.first with
    | Nil -> None
    | Cons { content; next = Nil } ->
        clear q;
        Some content
    | Cons { content; next } ->
        q.length <- q.length - 1;
        q.first <- next;
        Some content


  let pop = take

  let pop_opt = take_opt

  let head_opt = peek_opt

  let tail_opt q =
    match q.last with
    | Nil -> None
    | Cons { content } -> Some content


  let is_empty q = q.length = 0

  let length q = q.length
end

let () =
  let num_cmd = Scanf.scanf "%d " (fun d -> d) in
  let queue = IntQueue.create () in
  for _ = 1 to num_cmd do
    let input = Scanf.scanf "%s " (fun s -> String.escaped s) in
    match input with
    | "push" ->
        let x = Scanf.scanf "%d " (fun d -> d) in
        IntQueue.push x queue
    | "pop" -> (
        match IntQueue.pop_opt queue with
        | Some elt -> Printf.printf "%d\n" elt
        | None -> Printf.printf "-1\n" )
    | "size" -> Printf.printf "%d\n" (IntQueue.length queue)
    | "empty" -> Printf.printf "%d\n" (if IntQueue.is_empty queue then 1 else 0)
    | "front" -> (
        match IntQueue.head_opt queue with
        | Some elt -> Printf.printf "%d\n" elt
        | None -> Printf.printf "-1\n" )
    | "back" -> (
        match IntQueue.tail_opt queue with
        | Some elt -> Printf.printf "%d\n" elt
        | None -> Printf.printf "-1\n" )
    | _ -> ()
  done
