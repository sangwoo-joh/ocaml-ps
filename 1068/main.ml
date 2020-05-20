module Node = struct
  type t = int

  let compare = Stdlib.compare
end

module NodeMap = Map.Make (Node)
module NodeSet = Set.Make (Node)

module Digraph = struct
  module S = NodeSet
  module M = NodeMap

  type t = S.t M.t

  let empty : t = M.empty

  let mem_vertex g v = M.mem v g

  let mem_edge g v1 v2 = try S.mem v2 (M.find v1 g) with Not_found -> false

  let add_vertex g v = if mem_vertex g v then g else M.add v S.empty g

  let unsafe_add_edge g v1 v2 = M.add v1 (S.add v2 (M.find v1 g)) g

  let add_edge g v1 v2 =
    if mem_edge g v1 v2 then g
    else
      let g = add_vertex g v1 in
      let g = add_vertex g v2 in
      unsafe_add_edge g v1 v2


  let remove_vertex g v =
    if mem_vertex g v then
      let g = M.remove v g in
      M.fold (fun k s -> M.add k (S.remove v s)) g empty
    else g


  let is_leaf g v = try S.is_empty (M.find v g) with Not_found -> false

  let iter_succ g ~f ~src = try S.iter f (M.find src g) with Not_found -> ()
end

module Dfs (G : module type of Digraph) = struct
  module H = Hashtbl

  let fold ~f ~init ~g ~root =
    let explored = H.create 50 in
    let frontier = Stack.create () in
    let push v =
      if not (H.mem explored v) then (
        H.add explored v () ;
        Stack.push v frontier )
    in
    let rec loop acc =
      if Stack.is_empty frontier then acc
      else
        let visit = Stack.pop frontier in
        let acc = f visit acc in
        G.iter_succ g ~f:push ~src:visit ;
        loop acc
    in
    push root ;
    loop init
end

type graph = {g: Digraph.t ref; root: Node.t ref}

let empty = {g= ref Digraph.empty; root= ref (-1)}

let count_leaves {g; root} =
  if Digraph.mem_vertex !g !root then
    let module DFS = Dfs (Digraph) in
    DFS.fold
      ~f:(fun node acc -> if Digraph.is_leaf !g node then succ acc else acc)
      ~init:0 ~g:!g ~root:!root
  else 0


let build_digraph total {g; root} =
  for i = 0 to total - 1 do
    Scanf.scanf "%d " (fun parent ->
        if parent = -1 then (
          root := i ;
          g := Digraph.add_vertex !g i )
        else g := Digraph.add_edge !g parent i)
  done


let solve () =
  let ({g; root} as graph) = empty in
  Scanf.scanf "%d " (fun total -> build_digraph total graph) ;
  Scanf.scanf "%d " (fun rm -> g := Digraph.remove_vertex !g rm) ;
  let answer = count_leaves graph in
  Format.printf "%d\n" answer


let () = solve ()
