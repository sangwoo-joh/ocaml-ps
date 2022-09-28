module DisjointSet = struct
  module type Elt = sig
    type t

    val equal : t -> t -> bool

    val hash : t -> int
  end

  module Make (Elt : Elt) = struct
    type elt = Elt.t

    type t = {
      data : (elt, elt) Hashtbl.t;
      size : int ref;
      rank : (elt, int) Hashtbl.t;
    }

    let empty =
      { data = Hashtbl.create 100; size = ref 0; rank = Hashtbl.create 100 }


    let make_set t elt =
      if not (Hashtbl.mem t.data elt) then (
        Hashtbl.add t.data elt elt;
        Hashtbl.add t.rank elt 0;
        incr t.size)


    let rec find t elt =
      make_set t elt;
      let parent = Hashtbl.find t.data elt in
      if parent <> elt then
        (* path compression *)
        Hashtbl.replace t.data elt (find t parent);
      Hashtbl.find t.data elt


    let rec union t x y =
      let union_aux leaf trunk =
        Hashtbl.replace t.data leaf trunk;
        decr t.size
      in

      let px = find t x in
      let py = find t y in

      if px = py then ()
      else
        (* rank compression *)
        let rankx = Hashtbl.find t.rank px in
        let ranky = Hashtbl.find t.rank py in

        if rankx < ranky then union_aux px py
        else if ranky > rankx then union_aux py px
        else (
          union_aux py px;
          Hashtbl.replace t.rank px (rankx + 1))


    let disjoint t x y = find t x <> find t y

    let length t = !(t.size)
  end
end

module DisjointIntSet = DisjointSet.Make (struct
  include Int

  let hash = Hashtbl.hash
end)

let () =
  Scanf.scanf "%d %d " (fun _n m ->
      let disjoint_set = DisjointIntSet.empty in
      for i = 1 to m do
        Scanf.scanf "%d %d %d " (fun cmd x y ->
            match cmd with
            | 0 ->
                (* union *)
                DisjointIntSet.union disjoint_set x y
                (* union root x y *)
            | 1 ->
                (* find *)
                Printf.printf "%s\n"
                  (if DisjointIntSet.disjoint disjoint_set x y then "NO"
                  else "YES")
            | _ -> assert false)
      done)
