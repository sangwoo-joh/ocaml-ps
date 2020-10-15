let to_digits n =
  let rec aux acc n = if n = 0 then acc else aux ((n mod 10) :: acc) (n / 10) in
  aux [] n


let check digits =
  let rec aux diff digits =
    match digits with
    | [] -> true
    | [ _ ] -> true
    | d1 :: (d2 :: tl as remaining) -> (
        match diff with
        | None ->
            let d = d1 - d2 in
            aux (Some d) remaining
        | Some d ->
            let d' = d1 - d2 in
            if d = d' then aux diff remaining else false )
  in
  aux None digits


let is_hansu n =
  if n < 100 then true
  else (* assert that n >= 100 *)
       (* assert that n <= 1000 *)
    check (to_digits n)


let num_hansu range =
  let cnt = ref 0 in
  for n = 1 to range do
    if is_hansu n then incr cnt
  done;
  !cnt


let () = Scanf.scanf "%d" (fun n -> print_int (num_hansu n))
