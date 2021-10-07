let rec find root x =
  if root.(x) = x then x
  else (
    (* path compression *)
    root.(x) <- find root root.(x);
    root.(x))


let union root rank x y =
  let root_x = find root x in
  let root_y = find root y in
  if root_x = root_y then ()
  else if (* rank compression *)
          rank.(root_x) < rank.(root_y) then root.(root_x) <- root_y
  else if rank.(root_y) < rank.(root_x) then root.(root_y) <- root_x
  else (
    root.(root_x) <- root_y;
    rank.(root_x) <- rank.(root_x) + 1)


let same root x y = find root x = find root y

let () =
  Scanf.scanf "%d %d " (fun n m ->
      let root = Array.init (n + 1) (fun i -> i) in
      let rank = Array.init (n + 1) (fun i -> 0) in
      for i = 1 to m do
        Scanf.scanf "%d %d %d " (fun cmd x y ->
            match cmd with
            | 0 ->
                (* union *)
                union root rank x y
            | 1 ->
                (* find *)
                Printf.printf "%s\n " (if same root x y then "YES" else "NO")
            | _ -> assert false)
      done)
