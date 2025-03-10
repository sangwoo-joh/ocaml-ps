exception Exit

let rec scan () =
  let x, y, z = Scanf.scanf "%d %d %d " (fun x y z -> x, y, z) in
  if x = 0 && y = 0 && z = 0 then raise Exit;
  let longest = max x y |> max z in
  let twosum = x + y + z - longest in
  if twosum <= longest
  then Printf.printf "Invalid\n"
  else if x = y && y = z
  then Printf.printf "Equilateral\n"
  else if x = y || y = z || z = x
  then Printf.printf "Isosceles\n"
  else Printf.printf "Scalene\n";
  scan ()
;;

let () =
  try scan () with
  | Exit -> ()
;;
