exception Early_exit

let count_cycle n =
  let cycle = ref 0 in
  let nn = ref n in
  ( try
      while true do
        let a, b = (!nn / 10, !nn mod 10) in
        let s = a + b in
        nn := (b * 10) + (s mod 10) ;
        incr cycle ;
        if !nn = n then raise Early_exit
      done
    with Early_exit -> () ) ;
  !cycle


let () = Scanf.scanf "%d " (fun n -> Format.printf "%d@." (count_cycle n))
