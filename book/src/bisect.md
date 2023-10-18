# Bisect

```ocaml
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
```

