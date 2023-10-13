let counter nums =
  let tbl = Hashtbl.create 100 in
  let rec loop = function
    | [] -> ()
    | x :: xs ->
      let count =
        try Hashtbl.find tbl x with
        | Not_found -> 0
      in
      Hashtbl.replace tbl x (succ count);
      loop xs
  in
  loop nums;
  tbl
;;

let () =
  let n = Scanf.scanf "%d " (fun x -> x) in
  let rec loop t acc =
    if t = n then acc else loop (succ t) (Scanf.scanf "%d " (fun x -> x) :: acc)
  in
  let counter = loop 0 [] |> counter in
  Scanf.scanf "%d " (fun tofind ->
    match Hashtbl.find_opt counter tofind with
    | Some x -> Printf.printf "%d\n" x
    | None -> Printf.printf "0\n")
;;
