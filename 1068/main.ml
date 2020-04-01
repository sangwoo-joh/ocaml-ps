module F = Format

module Node = struct
  type t = int

  let compare = Stdlib.compare

  let equal = Stdlib.( = )

  let hash = Hashtbl.hash
end

module NodeMap = struct
  include Map.Make (Node)

  let find_and_raise k m s = try find k m with Not_found -> invalid_arg s
end

module NodeSet = struct
  include Set.Make (Node)
end

module Digraph = struct
  module S = NodeSet
  module M = NodeMap

  type t = S.t M.t

  type vertex = M.key

  type edge = vertex * vertex

  let empty : t = NodeMap.empty

  let mem_vertex g v = M.mem v g

  let mem_edge g v1 v2 = try S.mem v2 (M.find v1 g) with Not_found -> false

  let unsafe_add_vertex g v = M.add v S.empty g

  let add_vertex g v = if M.mem v g then g else unsafe_add_vertex g v

  let unsafe_add_edge g v1 v2 = M.add v1 (S.add v2 (M.find v1 g)) g

  let add_edge g v1 v2 =
    if mem_edge g v1 v2 then g
    else
      let g = add_vertex g v1 in
      let g = add_vertex g v2 in
      unsafe_add_edge g v1 v2

  let remove_vertex g v =
    if M.mem v g then
      let g = M.remove v g in
      M.fold (fun k s -> M.add k (S.remove v s)) g empty
    else g

  let is_leaf g v =
    if M.mem v g then
      let succ = M.find_and_raise v g "[is_leaf]" in
      S.is_empty succ
    else true

  let iter_succ f g v = S.iter f (M.find_and_raise v g "[iter_succ]")

  let fold_vertex f = M.fold (fun v _ -> f v)
end

module Dfs (G : module type of Digraph) = struct
  module H = Hashtbl.Make (Node)

  let fold ~f ~init ~g ~root =
    let explored = H.create 97 in
    let frontier = Stack.create () in
    let push v =
      if not (H.mem explored v) then (
        H.add explored v () ; Stack.push v frontier )
    in
    let rec loop acc =
      if not (Stack.is_empty frontier) then (
        let visit = Stack.pop frontier in
        let acc = f visit acc in
        G.iter_succ push g visit ; loop acc )
      else acc
    in
    push root ; loop init
end

type graph = {g: Digraph.t ref; root: Node.t ref}

let empty = {g= ref Digraph.empty; root= ref (-1)}

let count_leaves {g; root} =
  if not (Digraph.mem_vertex !g !root) then 0
  else
    let module DFS = Dfs (Digraph) in
    DFS.fold
      ~f:(fun node acc -> if Digraph.is_leaf !g node then succ acc else acc)
      ~init:0 ~g:!g ~root:!root

let solve () =
  let ({g; root} as graph) = empty in
  Scanf.scanf "%d " (fun total ->
      for i = 0 to total - 1 do
        Scanf.scanf "%d " (fun parent ->
            if parent = -1 then (
              root := i ;
              g := Digraph.add_vertex !g i )
            else g := Digraph.add_edge !g parent i)
      done) ;
  Scanf.scanf "%d" (fun rm -> g := Digraph.remove_vertex !g rm) ;
  let answer = count_leaves graph in
  F.printf "%d\n" answer

let () = solve ()
