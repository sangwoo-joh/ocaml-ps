module Lru_cache = struct
  type node = { key : char; mutable prev : node; mutable next : node }

  type t = { sentinel : node; map : (char, node ref) Hashtbl.t; capacity : int }

  let create capacity =
    let rec sentinel = { key = ' '; prev = sentinel; next = sentinel } in
    let map : (char, node ref) Hashtbl.t = Hashtbl.create 100 in
    { sentinel; map; capacity }


  let put t v =
    let hoist node =
      (* move an existing element to the first *)
      let sentinel = t.sentinel in
      let node_prev = node.prev in
      let node_next = node.next in
      (* unlink node *)
      node_prev.next <- node_next;
      node_next.prev <- node_prev;
      (* hoist node upto first *)
      let first = sentinel.next (* find first here! *) in
      node.prev <- sentinel;
      node.next <- first;
      first.prev <- node;
      sentinel.next <- node
    in

    let pop () =
      (* pop the least-recently-used item *)
      let sentinel = t.sentinel in
      let last = sentinel.prev in
      let last_prev = last.prev in
      last_prev.next <- sentinel;
      sentinel.prev <- last_prev;
      let key = last.key in
      Hashtbl.remove t.map key
    in

    (match Hashtbl.find_opt t.map v with
    | Some node ->
        (* key already exist. hoist up as it is recently used. *)
        hoist !node
    | None ->
        (* key not exist. insert into the head *)
        let sentinel = t.sentinel in
        let first = sentinel.next in
        let fresh = { key = v; prev = sentinel; next = first } in
        first.prev <- fresh;
        sentinel.next <- fresh;
        Hashtbl.add t.map v (ref fresh));

    if Hashtbl.length t.map > t.capacity then pop ()


  let content t =
    (* Reversed contents *)
    let buf = Buffer.create t.capacity in
    let rec loop node () =
      if node == t.sentinel then ()
      else (
        Buffer.add_char buf node.key;
        loop node.prev ())
    in
    loop t.sentinel.prev ();
    Buffer.contents buf
end

module P = Printf

let simulate tc cap cmd_str =
  P.printf "Simulation %d\n" tc;
  let lru_cache = Lru_cache.create cap in
  let rec process cmd =
    if cmd = '!' then P.printf "%s\n" (Lru_cache.content lru_cache)
    else Lru_cache.put lru_cache cmd
  in
  String.iter process cmd_str


exception Done

let tc = ref 1

let rec loop () =
  let line = read_line () in
  (if line = "0" then raise Done
  else
    match String.split_on_char ' ' line with
    | [ cap; cmd_str ] ->
        let cap = int_of_string cap in
        simulate !tc cap cmd_str;
        incr tc
    | _ -> assert false);
  loop ()


let () = try loop () with Done -> ()
