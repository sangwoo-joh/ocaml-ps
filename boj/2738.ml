let () =
  let n, m = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let m1 = Array.make_matrix n m 0 in
  for i = 0 to n - 1 do
    for j = 0 to m - 1 do
      m1.(i).(j) <- Scanf.scanf "%d " Fun.id
    done
  done;
  for i = 0 to n - 1 do
    for j = 0 to m - 1 do
      m1.(i).(j) <- m1.(i).(j) + Scanf.scanf "%d " Fun.id
    done
  done;
  for i = 0 to n - 1 do
    for j = 0 to m - 1 do
      Printf.printf "%d " m1.(i).(j)
    done;
    Printf.printf "\n"
  done
;;
