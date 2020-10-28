let radix = Array.init 10_001 (fun _ -> 0)

let print arr =
  Array.iteri
    (fun n cnt ->
      if cnt = 0 then ()
      else
        for _ = 1 to cnt do
          Printf.printf "%d\n" n
        done)
    arr


let () =
  Scanf.scanf "%d " (fun total ->
      for _ = 1 to total do
        Scanf.scanf "%d " (fun n -> radix.(n) <- radix.(n) + 1)
      done;
      print radix)
