let star n =
  for row = 1 to n do
    for col = 1 to n - row do
      print_char ' '
    done;
    for _ = 1 to (2 * row) - 1 do
      print_char '*'
    done;
    print_char '\n'
  done;
  for row = n + 1 to (2 * n) - 1 do
    for col = 1 to row - n do
      print_char ' '
    done;
    for _ = 1 to (((2 * n) - 1 - row) * 2) + 1 do
      print_char '*'
    done;
    print_char '\n'
  done
;;

let () =
  let n = read_int () in
  star n
;;
