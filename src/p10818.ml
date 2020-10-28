let () =
  Scanf.scanf "%d " (fun total ->
      let min = ref 1_000_000 in
      let max = ref (-1_000_000) in
      for i = 1 to total do
        Scanf.scanf "%d " (fun n ->
            if n < !min then min := n;
            if n > !max then max := n)
      done;
      Printf.printf "%d %d" !min !max)
