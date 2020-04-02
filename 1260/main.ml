module Node = struct
  type t = int

  let compare = Stdlib.compare

  let equal = Stdlib.( = )

  let hash = Hashtbl.hash

  let print t = Format.printf "%d " t

  let pp fmt n = Format.fprintf fmt "[%d]" n
end

module NodeTbl = struct
  include Hashtbl.Make (Node)

  let pp ~pp_value fmt m =
    let pp_item fmt (k, v) = Format.fprintf fmt "%a -> {%a}@." Node.pp k pp_value v in
    iter (fun k v -> Format.fprintf fmt "@[%a@]@." pp_item (k, v)) m
end

module NodeSet = struct
  include Set.Make (Node)

  let pp fmt s =
    let pp_elt fmt e = Format.fprintf fmt "%a, @," Node.pp e in
    iter (fun elt -> Format.fprintf fmt "@[%a@]" pp_elt elt) s
end

module Bigraph = struct
  module S = NodeSet
  module H = NodeTbl

  type t = S.t H.t

  let pp = H.pp ~pp_value:S.pp

  let empty : t = H.create 1000

  let mem_vertex g v = H.mem g v

  let mem_edge g v1 v2 = try S.mem v2 (H.find g v1) with Not_found -> false

  let add_vertex g v = if mem_vertex g v then () else H.add g v S.empty

  let unsafe_add_edge g v1 v2 = H.add g v1 (S.add v2 (H.find g v1))

  let add_edge g v1 v2 =
    if mem_edge g v1 v2 then ()
    else (
      add_vertex g v1 ;
      add_vertex g v2 ;
      unsafe_add_edge g v1 v2 ;
      unsafe_add_edge g v2 v1 )


  let iter_succ g ~f ~src = try S.iter f (H.find g src) with Not_found -> ()
end

module Dfs (G : module type of Bigraph) = struct
  module H = Hashtbl.Make (Node)

  let iter ~f ~g ~root =
    let explored = H.create 2048 in
    let rec loop v =
      if not (H.mem explored v) then (
        H.add explored v () ;
        f v ;
        G.iter_succ g ~f:loop ~src:v )
    in
    loop root
end

module Bfs (G : module type of Bigraph) = struct
  module H = Hashtbl.Make (Node)

  let iter ~f ~g ~root =
    let explored = H.create 2048 in
    let frontier = Queue.create () in
    let push v =
      if not (H.mem explored v) then (
        Queue.push v frontier ;
        H.add explored v () )
    in
    let rec loop () =
      if Queue.is_empty frontier then ()
      else
        let v = Queue.pop frontier in
        f v ;
        G.iter_succ g ~f:push ~src:v ;
        loop ()
    in
    push root ;
    loop ()
end

type graph = {g: Bigraph.t; root: Node.t ref}

let empty = {g= Bigraph.empty; root= ref (-1)}

let build_digraph num_v num_e root_id {g; root} =
  root := root_id ;
  for i = 0 to num_e - 1 do
    Scanf.scanf "%d %d\n" (fun src snk -> Bigraph.add_edge g src snk)
  done


let solve () =
  let ({g; root} as graph) = empty in
  Scanf.scanf "%d %d %d\n" (fun num_v num_e root_id -> build_digraph num_v num_e root_id graph) ;
  (* Format.printf "@[%a@]@." Bigraph.pp !g ; *)
  let module DFS = Dfs (Bigraph) in
  let module BFS = Bfs (Bigraph) in
  DFS.iter ~f:Node.print ~g ~root:!root ;
  Format.printf "\n" ;
  BFS.iter ~f:Node.print ~g ~root:!root


let () = solve ()
