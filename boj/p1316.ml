module Checked = Hashtbl.Make (struct
  type t = char

  let equal = Char.equal

  let hash = Hashtbl.hash
end)

exception Early_exit

let unsafe_check_gword w =
  let checked = Checked.create 26 in
  let chars = String.to_seqi w in
  Seq.iter
    (fun (idx, char) ->
      match Checked.find_opt checked char with
      | None -> Checked.add checked char idx
      | Some i ->
          if i + 1 != idx then raise Early_exit
          else Checked.replace checked char idx)
    chars;
  true


let is_gword w = try unsafe_check_gword w with Early_exit -> false

let () =
  Scanf.scanf "%d " (fun tc ->
      let gword_cnt = ref 0 in
      for i = 1 to tc do
        Scanf.scanf "%s " (fun w -> if is_gword w then incr gword_cnt)
      done;
      Format.printf "%d\n" !gword_cnt)
