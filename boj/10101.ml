let () =
  Scanf.scanf "%d %d %d " (fun a b c ->
    if a + b + c <> 180
    then Printf.printf "Error"
    else if a = b && b = c
    then Printf.printf "Equilateral"
    else if a = b || b = c || c = a
    then Printf.printf "Isosceles"
    else Printf.printf "Scalene")
;;
