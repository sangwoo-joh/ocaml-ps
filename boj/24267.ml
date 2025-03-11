let () =
  Scanf.scanf "%d " (fun n ->
    let run = ref 0 in
    for i = 1 to n - 2 do
      for j = i + 1 to n - 1 do
        for k = j + 1 to n do
          incr run
        done
      done
    done;
    Printf.printf "%d\n3" !run)
;;
