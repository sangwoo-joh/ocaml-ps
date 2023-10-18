let get_array n () = Array.init n (fun _ -> Scanf.scanf "%d " Fun.id)

let get_array_rl () =
  read_line ()
  |> String.split_on_char ' '
  |> List.map int_of_string
  |> Array.of_list
;;

let bisect arr x =
  let low, high = 0, Array.length arr in
  let rec loop low high =
    if not (low < high)
    then low
    else (
      let mid = (low + high) / 2 in
      if x <= arr.(mid) then loop low mid else loop (mid + 1) high)
  in
  loop low high
;;

let () =
  (* let n = Scanf.scanf "%d " Fun.id in *)
  ignore (read_line ());
  (* let arr = get_array n () in *)
  let arr = get_array_rl () in
  (* let m = Scanf.scanf "%d " Fun.id in *)
  ignore (read_line ());
  (* let ms = get_array m () in *)
  let ms = get_array_rl () in
  Array.fast_sort compare arr;
  let len = Array.length arr in
  let find x =
    let bi = bisect arr x in
    if bi < len && arr.(bi) = x
    then print_endline "1" (* Printf.printf "1\n" *)
    else print_endline "0" (* Printf.printf "0\n" *)
  in
  Array.iter find ms
;;
