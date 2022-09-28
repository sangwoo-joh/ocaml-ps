module F = Printf

let rec star y x n arr =
  if n = 1 then Bytes.set arr.(y) x '*'
  else
    for dy = 0 to 2 do
      for dx = 0 to 2 do
        if dx = 1 && dy = 1 then ()
        else
          let dn = n / 3 in
          star (y + (dn * dy)) (x + (dn * dx)) dn arr
      done
    done


let print_star n =
  let lines = Array.init n (fun _ -> Bytes.make n ' ') in
  star 0 0 n lines;
  Array.iter (fun line -> F.printf "%s\n" (Bytes.to_string line)) lines


let () = Scanf.scanf "%d" (fun n -> print_star n)
