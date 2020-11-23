let output picked =
  Array.iter (fun p -> Printf.printf "%d " p) picked;
  Printf.printf "\n"


let () =
  let n, m = Scanf.scanf "%d %d" (fun n m -> (n, m)) in
  let pick = Array.init m (fun _ -> 0) in
  let is_picked = Hashtbl.create n in
  let rec backtrack picked k prev =
    if k = m then output picked
    else if k > m then ()
    else
      for i = 1 to n do
        if i > prev && not (Hashtbl.mem is_picked i) then (
          Hashtbl.add is_picked i ();
          picked.(k) <- i;
          backtrack picked (k + 1) i;
          Hashtbl.remove is_picked i )
      done
  in

  backtrack pick 0 0
