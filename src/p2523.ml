let print_stars_9 n =
  for i = 1 to n do
    Format.printf "%s%s@."
      (String.make (i - 1) ' ')
      (String.make ((2 * n) - (2 * i) + 1) '*')
  done ;
  for i = 2 to n do
    Format.printf "%s%s@."
      (String.make (n - i) ' ')
      (String.make ((2 * i) - 1) '*')
  done


let () = Scanf.scanf "%d " (fun n -> print_stars_9 n)
