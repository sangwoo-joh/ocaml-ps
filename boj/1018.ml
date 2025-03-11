type board =
  { m : int
  ; n : int
  ; board : char array array
  }

let scan () =
  let n, m = Scanf.scanf "%d %d " (fun x y -> x, y) in
  let board = Array.make_matrix n m ' ' in
  for y = 0 to n - 1 do
    for x = 0 to m - 1 do
      board.(y).(x) <- Scanf.scanf "%c " Fun.id
    done
  done;
  { m; n; board }
;;

let reverse c = if c = 'W' then 'B' else 'W'

let search board row col =
  let aux0 init_state init_flip =
    let flip = ref init_flip in
    let prev = ref init_state in
    for y = row to row + 7 do
      for x = col to col + 7 do
        if y = row && x = col
        then ()
        else (
          if !prev = board.board.(y).(x) then incr flip;
          prev := reverse !prev)
      done;
      prev := reverse !prev
    done;
    !flip
  in
  min
    (aux0 board.board.(row).(col) 0)
    (aux0 (reverse board.board.(row).(col)) 1)
;;

let () =
  let board = scan () in
  let min_flip = ref 64 in
  for r = 0 to board.n - 1 do
    for c = 0 to board.m - 1 do
      if r + 8 <= board.n && c + 8 <= board.m
      then min_flip := min !min_flip (search board r c)
    done
  done;
  Printf.printf "%d" !min_flip
;;
