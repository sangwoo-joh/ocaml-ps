module Coord = struct
  type t = { x : int; y : int }

  let dummy : t = { x = 0; y = 0 }

  let make x y : t = { x; y }

  let compare t1 t2 =
    if t1.x = t2.x then Stdlib.compare t1.y t2.y else Stdlib.compare t1.x t2.x


  let print t = Printf.printf "%d %d\n" t.x t.y
end

let () =
  Scanf.scanf "%d " (fun total ->
      let coords = Array.make total Coord.dummy in
      for i = 0 to total - 1 do
        Scanf.scanf "%d %d " (fun x y -> coords.(i) <- Coord.make x y)
      done;
      Array.fast_sort Coord.compare coords;
      Array.iter (fun coord -> Coord.print coord) coords)
