(* this is not faster; this is actually slower!!!! *)
module HashSet = struct
  type t = (int, int option) Hashtbl.t

  let create () : t = Hashtbl.create 12
  let add (s : t) x = Hashtbl.add s x None
  let iter (s : t) ~f = Hashtbl.iter (fun node _ -> f node) s

  let singleton x =
    let t = create () in
    add t x;
    t
  ;;
end

module Graph = struct
  type t = (int, HashSet.t) Hashtbl.t

  let create () : t = Hashtbl.create 16

  let add_edge (g : t) src snk =
    match Hashtbl.find_opt g src with
    | Some edge -> HashSet.add edge snk
    | None -> Hashtbl.add g src (HashSet.singleton snk)
  ;;

  let dfs_iter g src ~(parent : int option) ~f =
    let visited = Hashtbl.create 16 in
    let has_visited x = Hashtbl.mem visited x in
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
        | Some edge ->
          HashSet.iter edge ~f:(fun node -> helper ~parent:(Some src) node))
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
    Printf.printf
      "%d\n"
      (match Hashtbl.find_opt parent_map s with
       | None -> -1
       | Some x -> x)
  done
;;
