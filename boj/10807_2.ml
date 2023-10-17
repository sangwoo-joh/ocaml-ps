let bisect ?(left = true) arr x =
  let low, high = 0, Array.length arr in
  let rec loop low high =
    if low >= high then low
    else (
      let mid = (low + high) / 2 in
      if left then (
        if x <= arr.(mid) then loop low mid else loop (mid + 1) high
      ) else (
        if x < arr.(mid) then loop low mid else loop (mid + 1) high
      )
    )
  in
  loop low high

let () =
  ignore (read_line ());
  let arr = read_line () |> String.split_on_char ' ' |> List.map int_of_string |> Array.of_list in
  let x = read_int () in
  Array.fast_sort compare arr;
  let left = bisect ~left:true arr x in
  let right = bisect ~left:false arr x in
  print_int (right - left)
