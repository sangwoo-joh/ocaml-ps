let rec star y x n =
  if y / n mod 3 = 1 && x / n mod 3 = 1 then Printf.printf " "
  else if n / 3 = 0 then Printf.printf "*"
  else star y x (n / 3)


let print_star n =
  for y = 0 to n - 1 do
    for x = 0 to n - 1 do
      star y x n
    done;
    Printf.printf "\n"
  done
