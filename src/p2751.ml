let () =
  Scanf.scanf "%d " (fun total ->
      let nums = Array.make total 0 in
      for i = 0 to total - 1 do
        Scanf.scanf "%d " (fun n -> nums.(i) <- n)
      done;
      Array.fast_sort compare nums;
      Array.iter (Printf.printf "%d\n") nums)
