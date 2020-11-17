module Node = struct
  include Int

  let hash = Hashtbl.hash
end

module Network = struct
  module S = Set.Make (Node)
  module H = Hashtbl.Make (Node)

  type t = S.t H.t

  let empty : t = H.create 100

  let mem_edge g v1 v2 = try S.mem v2 (H.find g v1) with Not_found -> false

  let add_vertex g v = if H.mem g v then () else H.add g v S.empty

  let unsafe_link g v1 v2 = H.replace g v1 (S.add v2 (H.find g v1))

  let add_edge g v1 v2 =
    if mem_edge g v1 v2 then ()
    else (
      add_vertex g v1;
      add_vertex g v2;
      unsafe_link g v1 v2;
      unsafe_link g v2 v1 )


  let iter_succ ~f ~src g = try S.iter f (H.find g src) with Not_found -> ()
end

module DFS (G : module type of Network) = struct
  module H = Hashtbl.Make (Node)

  let fold ~f ~root ~init g =
    let visited = H.create 50 in
    let going_to_visit = Stack.create () in
    let push v =
      if not (H.mem visited v) then (
        H.add visited v ();
        Stack.push v going_to_visit )
    in
    let rec loop acc =
      if Stack.is_empty going_to_visit then acc
      else
        let next = Stack.pop going_to_visit in
        let acc = f next acc in
        G.iter_succ ~f:push ~src:next g;
        loop acc
    in

    push root;
    loop init
end

let () =
  let read_int () = Scanf.scanf "%d " (fun d -> d) in
  let _ = read_int () in
  let total_edge = read_int () in
  let network = Network.empty in
  for _ = 1 to total_edge do
    Network.add_edge network (read_int ()) (read_int ())
  done;
  let module DFS_Network = DFS (Network) in
  Printf.printf "%d"
    (pred (DFS_Network.fold ~f:(fun _ acc -> succ acc) ~root:1 ~init:0 network))
