module Seq = struct
  include Seq

  let rec find p xs =
    match xs () with
    | Nil -> None
    | Cons (x, xs) -> if p x then Some x else find p xs
  ;;
end

let scan () = Scanf.scanf "%d %d " (fun x y -> x, y)

let () =
  let xs, ys = Hashtbl.create 10, Hashtbl.create 10 in
  let update (x, y) =
    Hashtbl.replace xs x (match Hashtbl.find_opt xs x with | None -> 1 | Some c -> c + 1);
    Hashtbl.replace ys y (match Hashtbl.find_opt ys y with | None -> 1 | Some c -> c + 1)
  in
  scan () |> update;
  scan () |> update;
  scan () |> update;
  let p = fun (_, c) -> c = 1 in
  let x = Hashtbl.to_seq xs |> Seq.find p |> Option.get |> fst in
  let y = Hashtbl.to_seq ys |> Seq.find p |> Option.get |> fst in
  Printf.printf "%d %d" x y
;;
