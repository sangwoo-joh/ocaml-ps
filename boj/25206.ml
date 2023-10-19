let () =
  let grades = ref [] in
  for _ = 1 to 20 do
    let record = read_line () |> String.split_on_char ' ' in
    grades
    := (List.hd record, List.nth record 1 |> float_of_string, List.nth record 2)
       :: !grades
  done;
  let grades = List.filter (fun (_, _, g) -> g <> "P") !grades in
  let grade_sum acc record =
    let _, hakjum, grade = record in
    let grade =
      match grade with
      | "A+" -> 4.5
      | "A0" -> 4.0
      | "B+" -> 3.5
      | "B0" -> 3.0
      | "C+" -> 2.5
      | "C0" -> 2.0
      | "D+" -> 1.5
      | "D0" -> 1.0
      | "F" -> 0.0
      | _ -> failwith "invalid"
    in
    acc +. (grade *. hakjum)
  in
  let total = List.fold_left grade_sum 0.0 grades in
  let total_n = List.fold_left (fun acc (_, h, _) -> acc +. h) 0.0 grades in
  Printf.printf "%f" (total /. total_n)
;;
