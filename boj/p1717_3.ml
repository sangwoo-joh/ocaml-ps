let phys_equal = Stdlib.( == )

type node =
  | PointsTo of node ref
  (* [PointsTo x] is a node whose parent is [x]. *)
  | Representative of int ref

let is_root = function
  | PointsTo _ -> false
  | Representative _ -> true

let create () = ref (Representative (ref 0))

let rec find t =
  let rec compress t ~prev ~descendants =
    match !t with
    | Representative r ->
        List.iter (fun n -> n := !prev) descendants;
        (t, r)
    | PointsTo t' -> compress t' ~prev:t ~descendants:(prev :: descendants)
  in
  match !t with
  | Representative r -> (t, r)
  | PointsTo t' ->
      (* compress t' ~child_node:node ~child:t ~descendants:[] *)
      compress t' ~prev:t ~descendants:[]


(* find t' *)

let root t = snd (find t)

let same_class t1 t2 = phys_equal (root t1) (root t2)

let union t1 t2 =
  let t1, r1 = find t1 in
  let t2, r2 = find t2 in
  if phys_equal t1 t2 then ()
  else if !r1 < !r2 then t1 := PointsTo t2
  else (
    t2 := PointsTo t1;
    if !r1 = !r2 then incr r1)


let () =
  Scanf.scanf "%d %d " (fun n m ->
      let sets = Array.init (n + 1) (fun i -> create ()) in
      for i = 1 to m do
        Scanf.scanf "%d %d %d " (fun cmd a b ->
            match cmd with
            | 0 -> union sets.(a) sets.(b)
            | 1 ->
                Printf.printf "%s\n"
                  (if same_class sets.(a) sets.(b) then "yes" else "no")
            | _ -> assert false)
      done)
