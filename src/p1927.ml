module PriorityQueue = struct
  include Map.Make (Int)

  let push x pq =
    update x
      (function
        | None -> Some 1
        | Some c -> Some (c + 1))
      pq


  let pop_min_opt pq =
    match min_binding_opt pq with
    | None -> (None, pq)
    | Some (x, c) ->
        let pq = if c = 1 then remove x pq else add x (c - 1) pq in
        (Some x, pq)
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
