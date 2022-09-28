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


  let iter q ~f ~fl =
    let rec iter_aux = function
      | Nil -> ()
      | Cons { content; next = Nil } -> fl content
      | Cons { content; next } ->
          f content;
          iter_aux next
    in
    iter_aux q.first


  let rev_iter q ~f ~fl =
    let rec iter_aux = function
      | Nil -> ()
      | Cons { content; prev = Nil } -> fl content
      | Cons { content; prev } ->
          f content;
          iter_aux prev
    in
    iter_aux q.last
end

exception Error

let case () =
  let cmds = String.escaped (read_line ()) in
  let _ = read_int () in
  let raw_data = String.escaped (read_line ()) in
  let raw_data = String.sub raw_data 1 (String.length raw_data - 2) in
  let numbers =
    try List.map int_of_string (String.split_on_char ',' raw_data)
    with _ -> []
  in
  let deq = Dequeue.create () in
  List.iter (fun n -> Dequeue.push_back n deq) numbers;
  let forward = ref true in
  try
    String.iter
      (function
        | 'R' -> forward := not !forward
        | 'D' -> (
            let drop =
              if !forward then Dequeue.pop_front_opt else Dequeue.pop_back_opt
            in
            match drop deq with
            | None -> raise Error
            | Some _ -> () )
        | _ -> assert false)
      cmds;
    let iter = if !forward then Dequeue.iter else Dequeue.rev_iter in
    Printf.printf "[";
    iter deq ~f:(Printf.printf "%d,") ~fl:(Printf.printf "%d");
    Printf.printf "]\n"
  with Error -> Printf.printf "error\n"


let () =
  let tc = read_int () in
  for _ = 1 to tc do
    case ()
  done
