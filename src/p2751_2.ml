let merge_sort ~arr =
  let total = Array.length arr in
  let cache = Array.make total 0 in
  let merge left_offset mid_offset right_offset =
    let li = ref left_offset in
    let ri = ref (mid_offset + 1) in
    let ci = ref left_offset in

    while !li <= mid_offset && !ri <= right_offset do
      let lv = arr.(!li) in
      let rv = arr.(!ri) in
      if lv < rv then (
        cache.(!ci) <- lv;
        incr li)
      else (
        cache.(!ci) <- rv;
        incr ri);
      incr ci
    done;

    while !li <= mid_offset do
      cache.(!ci) <- arr.(!li);
      incr li;
      incr ci
    done;

    while !ri <= right_offset do
      cache.(!ci) <- arr.(!ri);
      incr ri;
      incr ci
    done;

    (* restore *)
    Array.blit cache left_offset arr left_offset (right_offset - left_offset + 1)
  in

  let rec aux left right =
    if left < right then (
      let mid = (left + right) / 2 in
      aux left mid;
      aux (mid + 1) right;
      merge left mid right)
    else ()
  in
  aux 0 (total - 1)


let () =
  let total = Scanf.scanf "%d " (fun i -> i) in
  let nums = Array.make total 0 in
  for i = 0 to total - 1 do
    Scanf.scanf "%d " (fun n -> nums.(i) <- n)
  done;
  merge_sort ~arr:nums;
  Array.iter (Printf.printf "%d\n") nums
