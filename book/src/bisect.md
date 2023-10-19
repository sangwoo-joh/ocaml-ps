# Bisect

 이분 탐색을 일반화해서 정렬된 배열 `arr`과 찾고자 하는 값 `x`가 있을 때, `x`가 속한
 범위의 Lower Bound와 Upper Bound 를 구할 수 있다. C++에서는 `std::lower_bound` 와
 `std::upper_bound` 함수가 제공되고 Python에서는 `bisect_left`와 `bisect_right`가
 제공된다.

![c++ bisect](http://bajamircea.github.io/assets/2018-08-09-lower-bound/02-lower_bound_samples.png)

 위의 그림에서 볼 수 있는 것처럼 bisect에는 두 가지 특징이 있다.
 - `x`가 존재한다면, Lower Bound는 그 시작점의 인덱스이고 Upper Bound는 끝나는
   지점의 *다음 인덱스* 이다. 즉, `[lower_bound, upper_bound)`의 Half-open range로
   표현된다.
 - `x`가 없는 경우 `lower_bound == upper_bound`가 된다. Half-open range에서 공집합과
   같은 의미이다.

 보통 Lower Bound나 Upper Bound 하나만 찾으면 되는 문제가 많다. `x` 값의 인덱스를
 포함할 수도 있는 Lower Bound를 자주 쓰기에 이를 좀더 살펴보자.
 - Lower Bound 값이 배열 범위를 벗어나면 찾으려는 `x`값이 없다는 의미이다. 이는
   자명하다.
 - Lower Bound 값이 배열 범위 내 `[0, len)`에 있더라도, 직접 해당 인덱스의 값이
   `x`와 같은지 한번 더 확인해야 한다. 그 이유는 만약 찾으려는 값이 없으면서
   배열의 모든 값보다 작을 때 Lower Bound의 값이 0이기 때문이다.

 이를 바탕으로 OCaml의 `bisect`를 구현하면 다음과 같다.

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
