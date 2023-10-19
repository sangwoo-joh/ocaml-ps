type color =
  | White
  | Black

let () =
  let paper = Array.make_matrix 100 100 White in
  let n = Scanf.scanf "%d " Fun.id in
  for _ = 1 to n do
    let x, y = Scanf.scanf "%d %d " (fun x y -> x - 1, y - 1) in
    for r = x to x + 9 do
      for c = y to y + 9 do
        paper.(r).(c) <- Black
      done
    done
  done;
  let blacks = ref 0 in
  for x = 0 to 99 do
    for y = 0 to 99 do
      match paper.(x).(y) with
      | Black -> incr blacks
      | White -> ()
    done
  done;
  Printf.printf "%d" !blacks
;;
