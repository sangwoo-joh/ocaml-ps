let output picked =
  Array.iter (fun p -> Printf.printf "%d " p) picked;
  Printf.printf "\n"


let () =
  let n, m = Scanf.scanf "%d %d" (fun n m -> (n, m)) in
  let pick = Array.init m (fun _ -> 0) in
  let rec backtrack picked k prev =
    if k = m then output picked
    else if k > m then ()
    else
      for i = 1 to n do
        if prev <= i then (
          picked.(k) <- i;
          backtrack picked (k + 1) i )
      done
  in

  backtrack pick 0 1
