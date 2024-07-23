let () = Gc.set { (Gc.get ()) with space_overhead = 2500 }

module Graph = struct
  module Edge = Set.Make (Int)

  type t =
    { size : int
    ; graph : (Int.t, Edge.t) Hashtbl.t
    }

  let create n : t = { size = n; graph = Hashtbl.create 32000 }

  let add_edge t src snk =
    match Hashtbl.find_opt t.graph src with
    | None -> Hashtbl.add t.graph src (Edge.singleton snk)
    | Some e -> Hashtbl.replace t.graph src (Edge.add snk e)
  ;;

  let topo_order (t : t) =
    let visited = ref Edge.empty in
    let visit x = visited := Edge.add x !visited in
    let has_visited x = Edge.mem x !visited in
    let order = ref [] in
    let rec dfs x =
      visit x;
      (match Hashtbl.find_opt t.graph x with
       | None -> ()
       | Some edges ->
         Edge.iter (fun n -> if not (has_visited n) then dfs n) edges);
      order := x :: !order
    in
    for node = 1 to t.size do
      if not (has_visited node) then dfs node
    done;
    !order
  ;;
end

let () =
  let n, m = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let g = Graph.create n in
  for _ = 1 to m do
    Scanf.scanf "%d %d " (fun src snk -> Graph.add_edge g src snk)
  done;
  Graph.topo_order g |> List.iter (fun x -> Printf.printf "%d " x)
;;
