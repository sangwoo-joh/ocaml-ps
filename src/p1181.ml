module Word = struct
  include String

  let dummy = ""

  let compare t1 t2 =
    if length t1 = length t2 then compare t1 t2
    else Stdlib.compare (length t1) (length t2)
end

module WordSet = Set.Make (Word)

let () =
  Scanf.scanf "%d " (fun total ->
      let word_set = ref WordSet.empty in
      for i = 0 to total - 1 do
        Scanf.scanf "%s\n" (fun s -> word_set := WordSet.add s !word_set)
      done;
      WordSet.iter (Printf.printf "%s\n") !word_set)
