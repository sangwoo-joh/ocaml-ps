let () =
  Scanf.scanf "%d " (fun total ->
      let nums = ref [] in
      for i = 1 to total do
        Scanf.scanf "%d " (fun n -> nums := n :: !nums)
      done;
      let sorted = List.sort compare !nums in
      List.iter (Printf.printf "%d\n") sorted)
