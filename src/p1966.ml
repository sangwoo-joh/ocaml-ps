module Document = struct
  type t = { id : int; priority : int; mutable has_printed : bool }

  let make id priority = { id; priority; has_printed = false }

  let compare t1 t2 = Int.compare t2.priority t1.priority (* reverse order *)
end

let rec find_max p =
  match p with
  | [] -> assert false
  | hd :: tl -> if Document.(hd.has_printed) then find_max tl else hd


let load () =
  let q = Queue.create () in
  let p = ref [] in
  let n, m = Scanf.scanf "%d %d " (fun n m -> (n, m)) in
  for id = 0 to n - 1 do
    let priority = Scanf.scanf "%d " (fun p -> p) in
    let d =
      (* share same document in queue and list *)
      Document.make id priority
    in
    Queue.add d q;
    p := d :: !p
  done;
  (q, List.fast_sort Document.compare !p, m)


let solve q p m =
  let open Document in
  let rec step q p m k =
    match Queue.take_opt q with
    | None -> k
    | Some d ->
        let max = find_max p in
        if d.priority < max.priority then (
          Queue.add d q;
          step q p m k )
        else (
          (* print d *)
          d.has_printed <- true;
          let k' = succ k in
          if d.id = m then k' else step q p m k' )
  in
  step q p m 0


let () =
  Scanf.scanf "%d " (fun total ->
      for _ = 1 to total do
        let q, p, m = load () in
        let open Document in
        Printf.printf "%d\n" (solve q p m)
      done)
