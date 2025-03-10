let maximum_area x y z =
  let longest = max x y |> max z in
  let twosum = x + y + z - longest in
  if twosum <= longest
  then
    (* Invalid with the longest, adjust it *)
    Printf.printf "%d" (twosum + twosum - 1)
  else Printf.printf "%d" (x + y + z)
;;

let () = Scanf.scanf "%d %d %d " maximum_area
