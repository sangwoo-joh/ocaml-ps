let () =
  let homeworks = Array.make 30 false in
  for _ = 1 to 28 do
    let stu = Scanf.scanf "%d " Fun.id in
    homeworks.(stu - 1) <- true
  done;
  Array.iteri (fun i x -> if not x then Printf.printf "%d\n" (succ i)) homeworks
;;
