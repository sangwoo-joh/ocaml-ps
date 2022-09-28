let repeat n str =
  Seq.iter
    (fun c ->
      for i = 1 to n do
        print_char c
      done)
    (String.to_seq str)


let () =
  Scanf.scanf "%d " (fun tc ->
      for t = 1 to tc do
        Scanf.scanf "%d %s\n" (fun n str ->
            repeat n str;
            print_newline ())
      done)
