let make_hashtbl str =
  let char_seq = Seq.map Char.uppercase_ascii (String.to_seq str) in
  let hashtbl = Hashtbl.create 33 in
  Seq.iter
    (fun char ->
      match Hashtbl.find_opt hashtbl char with
      | None -> Hashtbl.add hashtbl char Int32.one
      | Some cnt -> Hashtbl.replace hashtbl char (Int32.succ cnt) )
    char_seq ;
  hashtbl

let find_max_freq_hashtbl hashtbl =
  let hashtbl_list = List.of_seq (Hashtbl.to_seq hashtbl) in
  let sorted =
    List.sort (fun x y -> -Int32.compare (snd x) (snd y)) hashtbl_list
  in
  match sorted with
  | [] -> '?'
  | [one] -> fst one
  | one :: two :: _ -> if snd one = snd two then '?' else fst one

let solve () =
  let solve_helper str =
    let freq_tbl = make_hashtbl str in
    let answer = find_max_freq_hashtbl freq_tbl in
    print_char answer
  in
  Scanf.scanf "%s" solve_helper

let () = solve ()
