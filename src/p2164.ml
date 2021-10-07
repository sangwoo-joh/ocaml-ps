exception Early_exit

let solve n =
  let q = Queue.create () in
  for num = 1 to n do
    Queue.push num q
  done;

  (try
     while Queue.length q != 1 do
       ignore (Queue.pop q);
       if Queue.length q = 1 then raise Early_exit;
       let top = Queue.take q in
       Queue.push top q
     done
   with
  | Early_exit -> ()
  | _ -> ());
  Printf.printf "%d\n" (Queue.top q)


let () = Scanf.scanf "%d" (fun n -> solve n)
