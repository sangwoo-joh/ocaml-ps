module Network = struct
  type t = { data : bool array array; size : int }

  let create n = { size = n; data = Array.make_matrix (succ n) (succ n) false }

  let add_edge g v1 v2 =
    g.data.(v1).(v2) <- true;
    g.data.(v2).(v1) <- true


  let fold ~f ~root ~init g =
    let module H = Hashtbl in
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
        for sink = 1 to g.size do
          if g.data.(next).(sink) then push sink
        done;
        loop acc
    in
    push root;
    loop init
end

let () =
  let read_int () = Scanf.scanf "%d " (fun d -> d) in
  let total_node = read_int () in
  let total_edge = read_int () in
  let network = Network.create total_node in
  for _ = 1 to total_edge do
    Network.add_edge network (read_int ()) (read_int ())
  done;
  Printf.printf "%d"
    (pred (Network.fold ~f:(fun _ acc -> succ acc) ~root:1 ~init:0 network))
