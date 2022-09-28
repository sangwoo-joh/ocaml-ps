module PriorityQueue = struct
  include Map.Make (Int)

  let push x pq =
    update (abs x)
      (function
        | None -> Some [ x ]
        | Some xs -> Some (List.fast_sort Stdlib.compare (x :: xs)))
      pq


  let pop_min_opt pq =
    match min_binding_opt pq with
    | None -> (None, pq)
    | Some (_, xs) -> (
        match xs with
        | [] -> assert false
        | [ x ] -> (Some x, remove (abs x) pq)
        | x :: tl ->
            let pq =
              update (abs x)
                (function
                  | None -> assert false
                  | Some _ -> Some tl)
                pq
            in
            (Some x, pq) )
end

let run p = function
  | 0 -> (
      match PriorityQueue.pop_min_opt p with
      | None, p ->
          Printf.printf "0\n";
          p
      | Some x, p ->
          Printf.printf "%d\n" x;
          p )
  | num -> PriorityQueue.push num p


let solve n =
  let p = ref PriorityQueue.empty in
  for _ = 1 to n do
    p := run !p (Scanf.scanf "%d " (fun d -> d))
  done


let () = solve (Scanf.scanf "%d " (fun d -> d))
