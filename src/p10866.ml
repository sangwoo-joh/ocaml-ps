module Dequeue = struct
  type 'a cell =
    | Nil
    | Cons of { content : 'a; mutable next : 'a cell; mutable prev : 'a cell }

  type 'a t = {
    mutable length : int;
    mutable first : 'a cell;
    mutable last : 'a cell;
  }

  let create () = { length = 0; first = Nil; last = Nil }

  let clear q =
    q.length <- 0;
    q.first <- Nil;
    q.last <- Nil


  let push_back x q =
    match q.last with
    | Nil ->
        q.length <- 1;
        let cell = Cons { content = x; next = Nil; prev = Nil } in
        q.first <- cell;
        q.last <- cell
    | Cons last ->
        q.length <- succ q.length;
        let cell = Cons { content = x; next = Nil; prev = q.last } in
        last.next <- cell;
        q.last <- cell


  let push_front x q =
    match q.first with
    | Nil -> push_back x q
    | Cons first ->
        q.length <- succ q.length;
        let cell = Cons { content = x; prev = Nil; next = q.first } in
        first.prev <- cell;
        q.first <- cell


  let front_opt q =
    match q.first with
    | Nil -> None
    | Cons first -> Some first.content


  let back_opt q =
    match q.last with
    | Nil -> None
    | Cons last -> Some last.content


  let size q = q.length

  let is_empty q = q.length = 0

  let pop_front_opt q =
    match q.first with
    | Nil -> None
    | Cons { content; next = Nil } ->
        clear q;
        Some content
    | Cons first ->
        q.length <- pred q.length;
        q.first <- first.next;
        ( match q.first with
        | Nil -> assert false
        | Cons new_first -> new_first.prev <- Nil );
        Some first.content


  let pop_back_opt q =
    match q.last with
    | Nil -> None
    | Cons { content; prev = Nil } ->
        clear q;
        Some content
    | Cons last ->
        q.length <- pred q.length;
        q.last <- last.prev;
        ( match q.last with
        | Nil -> assert false
        | Cons new_last -> new_last.next <- Nil );
        Some last.content
end

let print_opt = function
  | None -> Printf.printf "-1\n"
  | Some i -> Printf.printf "%d\n" i


let () =
  let num_cmd = Scanf.scanf "%d " (fun d -> d) in
  let deq = Dequeue.create () in
  for _ = 1 to num_cmd do
    let cmd = Scanf.scanf "%s " (fun s -> String.escaped s) in
    match cmd with
    | "push_front" -> Dequeue.push_front (Scanf.scanf "%d " (fun d -> d)) deq
    | "push_back" -> Dequeue.push_back (Scanf.scanf "%d " (fun d -> d)) deq
    | "pop_front" -> print_opt (Dequeue.pop_front_opt deq)
    | "pop_back" -> print_opt (Dequeue.pop_back_opt deq)
    | "size" -> Printf.printf "%d\n" (Dequeue.size deq)
    | "empty" -> Printf.printf "%d\n" (if Dequeue.is_empty deq then 1 else 0)
    | "front" -> print_opt (Dequeue.front_opt deq)
    | "back" -> print_opt (Dequeue.back_opt deq)
    | _ -> assert false
  done
