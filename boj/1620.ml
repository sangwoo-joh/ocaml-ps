let isnum c = '0' <= c && c <= '9'

let for_all f s =
  String.to_seq s |> Seq.fold_left (fun acc x -> acc && f x) true
;;

let isnum s = for_all isnum s

let () =
  let n, m = Scanf.scanf "%d %d\n" (fun x y -> x, y) in
  let p2n = Hashtbl.create 255 in
  let n2p = Hashtbl.create 255 in
  for i = 1 to n do
    let pokemon = Scanf.scanf "%s\n" Fun.id in
    Hashtbl.add p2n pokemon i;
    Hashtbl.add n2p i pokemon
  done;
  let solve () =
    let s = Scanf.scanf "%s\n" Fun.id in
    if isnum s
    then (
      let n = int_of_string s in
      Printf.printf "%s\n" (Hashtbl.find n2p n))
    else Printf.printf "%d\n" (Hashtbl.find p2n s)
  in
  for _ = 1 to m do
    solve ()
  done
;;
