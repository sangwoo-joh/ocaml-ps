let cute_or_not n =
  let cute = ref 0 in
  for i = 0 to n - 1 do
    Scanf.scanf "%d\n" (fun x -> if x = 1 then incr cute)
  done ;
  if !cute > n / 2 then print_string "Junhee is cute!"
  else print_string "Junhee is not cute!"


let solve () = Scanf.scanf "%d\n" (fun total -> cute_or_not total)

let () = solve ()
