let to_acc_min hour min = (hour * 60) + min

let to_hour_min acc_min =
  let hour = acc_min / 60 in
  let min = acc_min mod 60 in
  (hour, min)

let solve () =
  Scanf.scanf "%d %d" (fun hour min ->
      let alarm_time = to_acc_min hour min - 45 in
      let alarm_time' =
        if alarm_time < 0 then alarm_time + (24 * 60) else alarm_time
      in
      let hour', min' = to_hour_min alarm_time' in
      Printf.printf "%d %d" hour' min' )

let () = solve ()
