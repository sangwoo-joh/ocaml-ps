let make_array str =
  let char_seq = Seq.map Char.uppercase_ascii (String.to_seq str) in
  let arr = Array.make 26 0 in
  let to_idx ch = int_of_char ch - int_of_char 'A' in
  Seq.iter (fun ch -> arr.(to_idx ch) <- arr.(to_idx ch) + 1) char_seq ;
  arr

let find_max_freq_array arr =
  let to_char idx = char_of_int (idx + int_of_char 'A') in
  let third (_, _, c) = c in
  let res =
    Array.fold_left
      (fun (idx, max, answer) freq ->
        let idx' = idx + 1 in
        if max = freq then (idx', max, '?')
        else if max < freq then (idx', freq, to_char idx)
        else (idx', max, answer) )
      (0, 0, ' ') arr
  in
  third res

let solve () =
  let solve_helper str =
    let freq_arr = make_array str in
    let answer = find_max_freq_array freq_arr in
    print_char answer
  in
  Scanf.scanf "%s" solve_helper

let () = solve ()
