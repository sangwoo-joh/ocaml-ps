let escape x y w h =
  min (min (abs (x - 0)) (abs (y - 0))) (min (abs (x - w)) (abs (y - h)))
;;

let () =
  Scanf.scanf "%d %d %d %d " (fun x y w h ->
    Printf.printf "%d" (escape x y w h))
;;
