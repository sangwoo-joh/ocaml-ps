let d' n =
  let sum = ref 0 in
  let n' = ref n in
  while !n' != 0 do
    sum := !sum + (!n' mod 10);
    n' := !n' / 10
  done;
  !sum


let d n = n + d' n

let gen () =
  let a = Array.make 10_001 true in
  for n = 1 to 10_001 do
    let n' = ref n in
    (* this is ignored *)
    while !n' <= 10_001 do
      let next = d !n' in
      if next <= 10_000 then a.(next) <- false;
      n' := next
    done
  done;
  a


let () =
  let selfs = gen () in
  for n = 1 to 10_000 do
    if selfs.(n) then Format.printf "%d\n" n
  done
