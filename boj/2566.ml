let () =
  let max = ref Int.min_int in
  let row, col = ref 0, ref 0 in
  for r = 0 to 8 do
    for c = 0 to 8 do
      let v = Scanf.scanf "%d " Fun.id in
      if v > !max
      then (
        max := v;
        row := succ r;
        col := succ c)
    done
  done;
  Printf.printf "%d\n%d %d" !max !row !col
;;
