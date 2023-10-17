# Array

 `Array` 모듈의 함수를 살펴보자.

```ocaml
val make : init -> 'a -> 'a array

val create_float : int -> float array

val init : int -> (int -> 'a) -> 'a array

val make_matrix : int -> int -> 'a -> 'a array array

val length : 'a array -> int

val get : 'a array -> int -> 'a

val set : 'a array -> int -> 'a -> unit

val append : 'a array -> 'a array -> 'a array

val sub : 'a array -> int -> int -> 'a array

val blit : 'a array -> int -> 'a array -> int -> int -> unit

val sort : ('a -> 'a -> int) -> 'a array -> unit

val stable_sort : ('a -> 'a -> int) -> 'a array -> unit

val fast_sort : ('a -> 'a -> int) -> 'a array -> unit
```


## 생성

```ocaml
Array.make size x
```

 모든 원소가 `x`인 `size` 크기의 배열을 만든다. 이때 모든 원소들은 `x` 와 *물리적으로*
 같다. 즉 OCaml의 `==` 관계를 갖고, 이는 곧 같은 메모리를 가리킨다는 의미이다.
 그래서 `x`에 가변 데이터를 넣으면 배열의 모든 원소가 같은 메모리를 가리키게
 되므로 사이드 이펙트에 주의해야 한다.


```ocaml
Array.create_float size
```

 `size` 크기의 *실수* 배열을 만든다. OCaml의 메모리 표현방식에 따라 무작정 실수를
 배열에 담아버리면 모든 원소가 실수 값을 가리키는 굉장히 비효율적인 배열의
 메모리 레이아웃이 나오므로, 실수 배열은 특별 취급해준다.

```ocaml
Array.init size (fun idx -> ...)
```

 `make`랑 비슷한데 대신 `idx`에 따라 직접 원소의 초기값을 설정할 수 있게 해준다.

 참고로 인덱스랑 같은 값을 갖는 정수 배열을 초기화할 때는 `fun x -> x`를 넘겨주기
 보다는 다음과 같이 `Fun` 모듈의 `id` 함수를 쓰는게 좀더 효율적이다.

```ocaml
Array.init 5 Fun.id;;
(* create [|0; 1; 2; 3; 4;] *)
```

```ocaml
Array.make_matrix dim_x dim_y x
```

 역시 `create_float`과 비슷한 이유로 2차원 배열 (행렬) 의 경우 효율적인 메모리
 레이아웃을 고려하여 특별 취급해준다.

## 기본 연산

```ocaml
Array.get arr idx
(* equal to *)
arr.(idx)
```

 랜덤 인덱스 접근 연산이다. 아래 표현은 신택스 슈거다.

```ocaml
Array.set arr idx x
(* equal to *)
arr.(idx) <- x
```

 랜덤 인덱스 값을 업데이트하는 연산이다. 역시 아래 표현은 신택스 슈거다.

## Bisect

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
