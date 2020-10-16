let () =
  Scanf.scanf "%d" (fun n ->
      let answer = ref 0x9999 in
      let idx = ref (n / 5) in
      while !idx >= 0 do
        let t = n - (5 * !idx) in
        ( if t >= 0 && t mod 3 == 0 then
          let tmp_ans = !idx + (t / 3) in
          if tmp_ans < !answer then answer := tmp_ans );
        decr idx
      done;
      if !answer = 0x9999 then print_int (-1) else print_int !answer)
