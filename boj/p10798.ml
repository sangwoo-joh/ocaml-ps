let solve () =
  let inputs = ref [] in
  for i = 1 to 5 do
    inputs := read_line () :: !inputs
  done ;
  let inputs = List.rev !inputs in
  let cur = ref 0 in
  while !cur < 15 do
    List.iter
      (fun w -> if !cur < String.length w then print_char w.[!cur])
      inputs ;
    incr cur
  done


let () = solve ()
