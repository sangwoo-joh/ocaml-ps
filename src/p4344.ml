let proportion_above_avg scores =
  let sum = List.fold_left (fun acc s -> acc + s) 0 scores in
  let total = List.length scores in
  let avg = sum / total in
  let above_avg_cnt = List.length (List.filter (fun s -> s > avg) scores) in
  Format.printf "Sum: %d, Total: %d, Avg: %d, Above: %d\n" sum total avg above_avg_cnt;
  float_of_int above_avg_cnt /. float_of_int total *. 100.


let () =
  Scanf.scanf "%d " (fun tc ->
      for t = 1 to tc do
        Scanf.scanf "%d " (fun n ->
            let scores = ref [] in
            for i = 1 to n do
              Scanf.scanf "%d " (fun s -> scores := s :: !scores)
            done;
            Format.printf "%.3f%%\n" (proportion_above_avg !scores))
      done)
