module NameSet = Set.Make (String)

let () =
  let n = Scanf.scanf "%d\n" Fun.id in
  let names = ref NameSet.empty in
  for _ = 1 to n do
    Scanf.scanf "%s %s\n" (fun name status ->
      match status with
      | "enter" -> names := NameSet.add name !names
      | "leave" -> names := NameSet.remove name !names
      | _ -> failwith "impossible")
  done;
  NameSet.elements !names
  |> List.rev
  |> List.iter (fun x -> Printf.printf "%s\n" x)
;;
