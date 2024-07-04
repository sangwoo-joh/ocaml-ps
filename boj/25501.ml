let rec recursion s l r call =
  if l >= r
  then 1, call
  else if String.get s l <> String.get s r
  then 0, call
  else recursion s (l + 1) (r - 1) (call + 1)
;;

let is_palindrome s = recursion s 0 (String.length s - 1) 1

let () =
  let n = Scanf.scanf "%d\n" Fun.id in
  for _ = 1 to n do
    let s = Scanf.scanf "%s\n" Fun.id in
    let answer, calls = is_palindrome s in
    Printf.printf "%d %d\n" answer calls
  done
;;
