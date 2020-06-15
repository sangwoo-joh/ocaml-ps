type signed = Positive | Negative

let signed_of x = if x > 0 then Positive else Negative

let quadrant_of = function
  | Positive, Positive -> 1
  | Negative, Positive -> 2
  | Negative, Negative -> 3
  | Positive, Negative -> 4


let () =
  Scanf.scanf "%d %d " (fun x y ->
      print_int (quadrant_of (signed_of x, signed_of y)))
