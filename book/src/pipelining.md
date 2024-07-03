# Pipelining

OCaml 표준 라이브러리에는 다음과 같이 정의된 파이프라이닝 중위 연산자가 있다.

```ocaml
val ( |> ) : 'a -> ('a -> 'b) -> 'b
```

타입을 잘 살펴보자. `|> x f`는 `f`를 `x`에 적용한 결과이다. 즉, `|> x f`는 `f x`와 같다. 그런데 `|>`는 중위 연산자라서 `|> x f`는 `x |> f`로 쓸 수 있다. 즉, `x |> f`가 `f x`와 같다. 어떤 함수 `f`에 적용할 파라미터 `x`를 순서를 뒤바꿔서 쓸 수 있게 해주는 연산자이다.

이게 왜 유용할까? 우리가 문제를 풀기 위해서 문제를 잘개 쪼개어 풀 때, `f`를 먼저 생각하기 보다는 `x`를 먼저 생각하는 것이 더 자연스럽기 때문이다. 예를 들어 [백준 1269번](https://www.acmicpc.net/problem/1269) 문제를 보자. 이 문제의 입력은 (n, m을 제외하면) 공백으로 구분된 정수를 담은 한 줄로 된 문자열이다. 그렇다면 문제를 풀기 위해서 이 문자열을 원하는 입력으로 처리하는 자연스러운 과정을 생각해보면 다음과 같다.
 1. 문자열 한 줄을 입력 받아서 저장한다.
 2. 저장한 문자열을 공백을 기준으로 쪼개어 문자열의 리스트를 만든다.
 3. 문자열의 리스트를 정수 리스트로 변환한다.
 4. 정수 리스트의 모든 원소를 정수 집합에 추가한다.

이걸 파이프라이닝을 쓰지 않고 처리하면 다음과 같다.

```ocaml
let s = read_line () in
let xs = String.split_on_char ' ' s in
let is = List.map int_of_string xs in
let set = List.fold_left (fun acc x -> IntSet.add x acc) IntSet.empty is in
set
```

한 줄 한 줄 따라 읽으면 잘 이해는 되지만, 결국 최종적으로 `set`이라는 하나의 데이터를 만들어 내는 코드이므로 이를 위해 `s`, `xs`, `is` 등의 중간 변수들은 사실 불필요한 인지적 부하를 일으킨다. 그래서 이 작업을 한 줄로 처리하려면 다음과 같이 해야한다.

```ocaml
let set = List.fold_left (fun acc x -> IntSet.add x acc) IntSet.empty (List.map int_of_string (String.split_on_char ' ' (read_line ()))) in
set
```

이렇게하면 중간 변수들이 사라지긴 하지만, 대체 무슨 작업을 하는 코드인지 한눈에 파악하기가 굉장히 어려워진다. 그 이유는 `f (f (f ... (f x)))`와 같이, 바깥의 `f`에 적용하기 위한 파라미터를 계산하려면 안쪽의 `(f ... (f x))`를 평가해야 하기 때문이다. 즉, 다음과 같이 코드를 읽는 순서가 거꾸로다:
 1. 정수 리스트의 모든 원소를 정수 집합에 추가할 건데, 그 정수 리스트는;
 2. 문자열의 리스트를 변환한 것이고, 이 문자열의 리스트는;
 3. 어떤 문자열을 공백을 기준으로 쪼개어 문자열의 리스트로 만든 것이고, 이 문자열은;
 4. 입력으로 받은 문자열 한 줄이다.

파이프라이닝은 이러한 경우에 오컴의 면도날처럼 훌륭한 해결책을 제시한다: 중간 변수도 필요하지 않으며, 생각의 순서가 자연스럽다.

```ocaml
let set =
  read_line ()
  |> String.split_on_char ' '
  |> List.map int_of_string
  |> List.fold_left (fun acc x -> IntSet.add x acc) IntSet.empty
in
set
```

사실 많은 OCaml 함수들이 이런 파이프라이닝 (을 포함한 많은 체이닝 연산들) 을 염두에 두고, 가장 중요한 파라미터를 마지막에 받고 있다. 즉, `String.split_on_char`의 타입은 `char -> string -> string`으로 `string`을 가장 나중에 받고 있고, `List.map` 역시 `('a -> 'b) -> 'a list -> 'b list`로 `'a list`를 마지막에 받는다. 그 덕분에 이러한 자연스러운 파이프라이닝이 가능한 것이다.
