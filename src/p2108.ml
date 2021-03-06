module FreqMap = Map.Make (Int)

let most_freq freq =
  let freq_map =
    Hashtbl.fold
      (fun n f map ->
        FreqMap.update f
          (function
            | None -> Some [ n ]
            | Some ns -> Some (n :: ns))
          map)
      freq FreqMap.empty
  in
  let _, max_elts = FreqMap.max_binding freq_map in
  match List.sort compare max_elts with
  | [] -> assert false
  | [ n ] | _ :: n :: _ -> n


let () =
  Scanf.scanf "%d " (fun total ->
      let numbers = ref [] in
      let min, max = (ref 4_000, ref (-4_000)) in
      let freq = Hashtbl.create total in
      for _ = 1 to total do
        Scanf.scanf "%d " (fun n ->
            numbers := n :: !numbers;
            if n < !min then min := n;
            if n > !max then max := n;
            match Hashtbl.find_opt freq n with
            | None -> Hashtbl.add freq n 1
            | Some f -> Hashtbl.replace freq n (f + 1))
      done;
      let average =
        (List.fold_left ( + ) 0 !numbers |> float_of_int)
        /. (total |> float_of_int)
        |> Float.round
        |> int_of_float
      in
      let median = List.nth (List.sort compare !numbers) (total / 2) in
      let freq = most_freq freq in
      let range = !max - !min in
      Printf.printf "%d\n%d\n%d\n%d\n" average median freq range)
