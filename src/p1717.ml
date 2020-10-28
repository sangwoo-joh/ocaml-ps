let rec find root x =
  if root.(x) = x then x
  else (
    root.(x) <- find root root.(x);
    root.(x) )


let union root x y =
  let root_x = find root x in
  let root_y = find root y in
  if root_x = root_y then () else root.(root_x) <- root_y


let () =
  Scanf.scanf "%d %d " (fun n m ->
      let root = Array.init (n + 1) (fun i -> i) in
      for i = 1 to m do
        Scanf.scanf "%d %d %d " (fun cmd x y ->
            match cmd with
            | 0 ->
                (* union *)
                union root x y
            | 1 ->
                (* find *)
                let rep_x = find root x in
                let rep_y = find root y in
                if rep_x = rep_y then Printf.printf "YES\n"
                else Printf.printf "NO\n"
            | _ -> assert false)
      done)
