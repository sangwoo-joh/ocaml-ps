let series : int Stack.t = Stack.create ()

let commands : char Queue.t = Queue.create ()

let counter = ref 1

let push () =
  Stack.push !counter series;
  Queue.push '+' commands;
  incr counter


let check x = (not (Stack.is_empty series)) && Stack.top series = x

let pop () =
  ignore (Stack.pop_opt series);
  Queue.add '-' commands


let solve maybe_series =
  let total = Queue.length maybe_series in
  let rec try_pop () =
    try
      let x = Queue.top maybe_series in
      if check x then (
        ignore (Queue.take maybe_series);
        pop ();
        try_pop () )
    with Queue.Empty -> ()
  in

  for num = 1 to total do
    push ();
    try_pop ()
  done;

  if not (Stack.is_empty series) then Printf.printf "NO\n"
  else Queue.iter (Printf.printf "%c\n") commands


let get_maybe_series () =
  let maybe_series : int Queue.t = Queue.create () in
  let total = Scanf.scanf "%d " (fun d -> d) in
  for _ = 1 to total do
    Scanf.scanf "%d " (fun x -> Queue.push x maybe_series)
  done;
  maybe_series


let () = solve (get_maybe_series ())
