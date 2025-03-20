(** Graph consisting of nodes with integer ids *)
type node = int

module HashSet = struct
  module type S = sig
    type elt
    type t

    val create : ?random:bool -> int -> t
    val clear : t -> unit
    val add : t -> elt -> unit
    val remove : t -> elt -> unit
    val mem : t -> elt -> bool
    val iter : (elt -> unit) -> t -> unit
    val to_seq : t -> elt Seq.t
    val of_seq : elt Seq.t -> t
  end

  module Make (H : Hashtbl.HashedType) : S with type elt = H.t = struct
    type elt = H.t
    type set = (elt, elt option) Hashtbl.t
    type t = set

    let create = Hashtbl.create
    let clear = Hashtbl.clear
    let add t x = Hashtbl.add t x None
    let remove = Hashtbl.remove
    let mem = Hashtbl.mem
    let iter f t = Hashtbl.iter (fun x _ -> f x) t
    let to_seq t = Hashtbl.to_seq_keys t

    let of_seq s =
      let set = create 16 in
      Seq.iter (fun x -> add set x) s;
      set
    ;;
  end
end

module NodeSet = HashSet.Make (Int)
module NodeMap = Hashtbl.Make (Int)

module Edge = struct
  type t =
    { sink : node
    ; weight : int
    }

  let equal = ( = )
  let compare = compare
  let hash = Hashtbl.hash
end

module EdgeSet = HashSet.Make (Edge)

type t =
  { n_vertices : int
  ; n_edges : int
  ; directed : bool
  ; edges : (node, EdgeSet.t) Hashtbl.t
  }

let bfs
      ?(process_vertex_early = fun _node -> ())
      ?(process_vertex_late = fun _node -> ())
      ?(process_edge = fun _src _snk -> ())
      t
      (start : node)
  =
  let node_queue : node Queue.t = Queue.create () in
  let discovered = NodeSet.create 16 in
  let discover (x : node) = NodeSet.add discovered x in
  let is_discovered x = NodeSet.mem discovered x in
  let visited = NodeSet.create 16 in
  let visit x = NodeSet.add visited x in
  let is_visited x = NodeSet.mem visited x in
  let parent_info = NodeMap.create 16 in
  let born parent child = NodeMap.add parent_info child parent in
  Queue.add start node_queue;
  discover start;
  while not (Queue.is_empty node_queue) do
    let pioneer = Queue.take node_queue in
    process_vertex_early pioneer;
    visit pioneer;
    (match Hashtbl.find_opt t.edges pioneer with
     | None -> ()
     | Some edges ->
       EdgeSet.iter
         (fun (edge: Edge.t) ->
            if (not (is_visited edge.sink)) || t.directed
            then process_edge pioneer edge.sink;
            if not (is_discovered edge.sink)
            then (
              Queue.add edge.sink node_queue;
              discover edge.sink;
              born pioneer edge.sink))
         edges);
    process_vertex_late pioneer
  done;
  parent_info
;;
