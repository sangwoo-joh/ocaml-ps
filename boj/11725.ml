module Graph = struct
  module Edge = Set.Make (Int)

  type t = (int, Edge.t) Hashtbl.t

  let create () : t = Hashtbl.create 16

  let add_edge (g : t) src snk =
    match Hashtbl.find_opt g src with
    | Some edge -> Hashtbl.replace g src (Edge.add snk edge)
    | None -> Hashtbl.add g src (Edge.singleton snk)
  ;;

  let dfs_iter g src ~(parent : Edge.elt option) ~f =
    let visited = Hashtbl.create 16 in
    let has_visited x =
      match Hashtbl.find_opt visited x with
      | None -> false
      | Some _ -> true
    in
    let visit ~parent x =
      f parent x;
      Hashtbl.add visited x None
    in
    let rec helper ~parent src =
      if has_visited src
      then ()
      else (
        visit ~parent src;
        match Hashtbl.find_opt g src with
        | None -> ()
        | Some edge -> Edge.iter (helper ~parent:(Some src)) edge)
    in
    helper ~parent src
  ;;
end

let load () =
  let n = Scanf.scanf "%d " Fun.id in
  let g = Graph.create () in
  for _ = 1 to n - 1 do
    let src, snk = Scanf.scanf "%d %d " (fun x y -> x, y) in
    Graph.add_edge g src snk;
    Graph.add_edge g snk src
  done;
  g, n
;;

let () =
  let graph, n = load () in
  let parent_map = Hashtbl.create 16 in
  Graph.dfs_iter
    graph
    ~parent:None
    ~f:(fun parent src ->
      match parent with
      | None -> ()
      | Some p -> Hashtbl.add parent_map src p)
    1;
  for s = 2 to n do
    Printf.printf "%d\n" (Hashtbl.find parent_map s)
  done
;;
