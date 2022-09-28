module DisjointSet = struct
  module type Elt = sig
    type t

    val equal : t -> t -> bool

    val hash : t -> int
  end

  module Make (Elt : Elt) = struct
    type elt = Elt.t

    type t = { data : (elt, elt) Hashtbl.t; size : int ref }

    let empty = { data = Hashtbl.create 100; size = ref 0 }

    let make_set t elt =
      if not (Hashtbl.mem t.data elt) then (
        Hashtbl.add t.data elt elt;
        incr t.size )


    let rec find t elt =
      let parent = Hashtbl.find t.data elt in
      if parent <> elt then
        (* path compression *)
        Hashtbl.replace t.data elt (find t parent);
      Hashtbl.find t.data elt


    let union t x y =
      let px = find t x in
      let py = find t y in

      if px <> py then (
        decr t.size;
        Hashtbl.replace t.data px py )


    let length t = !(t.size)
  end
end

module City = struct
  include Int

  let hash = Hashtbl.hash
end

module CitySet = Set.Make (City)
module CityDisjointSet = DisjointSet.Make (City)

let () =
  let read () = Scanf.scanf "%d " (fun n -> n) in
  let n = read () in
  let m = read () in
  let graph = Array.make_matrix n n 0 in
  let plan = ref CitySet.empty in
  for x = 0 to n - 1 do
    for y = 0 to n - 1 do
      graph.(x).(y) <- read ()
    done
  done;
  for _ = 1 to m do
    plan := CitySet.add (read () - 1) !plan
  done;

  let disjoint_set = CityDisjointSet.empty in
  CitySet.iter
    (fun city ->
      CityDisjointSet.make_set disjoint_set city;
      for connected = 0 to n - 1 do
        if graph.(city).(connected) = 1 then (
          CityDisjointSet.make_set disjoint_set connected;
          CityDisjointSet.union disjoint_set city connected )
      done)
    !plan;

  let answer =
    if CityDisjointSet.length disjoint_set = 1 then "YES" else "NO"
  in
  Printf.printf "%s" answer
