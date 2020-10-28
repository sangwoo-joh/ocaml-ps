module Member = struct
  type t = { age : int; name : string }

  let dummy = { age = 0; name = "" }

  let compare t1 t2 = Stdlib.compare t1.age t2.age

  let print t = if t.age = 0 then () else Printf.printf "%d %s\n" t.age t.name
end

let () =
  Scanf.scanf "%d " (fun total ->
      let members = Array.make (2 * total) Member.dummy in
      for i = 0 to total - 1 do
        Scanf.scanf "%d %s\n" (fun age name ->
            members.(i) <- Member.{ age; name })
      done;
      Array.stable_sort Member.compare members;
      Array.iter Member.print members)
