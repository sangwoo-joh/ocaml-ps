# List

OCaml의 가장 기본적이며 가장 가볍게 자주 쓰이게 될 선형 데이터 구조 중 하나이다. 파이썬의 리스트(를 가장한 배열)과는 다르게 진짜로 링크드 리스트 구조이다. 대부분의 함수들이 재귀 함수로 구현되어 있는데, 그래서 *꼬리 재귀가 아닌* 함수들은 주의해서 호출해야 한다. 자칫 큰 리스트에 이런 함수를 호출하면 스택이 터질 수도 있다. 그래서 입력이 큰 경우는 꼬리 재귀 버전의 함수를 호출해야 해서 조금 비 직관적인 코드가 나올 수도 있다.

이름은 리스트이지만 그 동작은 **스택**과도 같다. 리스트의 헤드를 떼어 내는 작업이 O(1)이고, 리스트의 헤드에 원소를 추가하는 작업도 O(1)이기 때문에 이 성질을 활용할 수 있다. 반면에 리스트의 가장 마지막 원소를 가져오는 작업은 O(N)이며, 리스트의 가장 끝에 원소를 추가하는 작업은 직접 구현해야 하고 어떤 방법을 써도 O(N)이다.

## 기본 연산

```ocaml
val length : 'a list -> int

val compare_lengths : 'a list -> 'b list -> int

val compare_length_with : 'a list -> int -> int

val cons : 'a -> 'a list -> 'a list

val hd : 'a list -> 'a

val tl : 'a list -> 'a list

val nth : 'a list -> int -> 'a

val nth_opt : 'a list -> int -> 'a option

val rev : 'a list -> 'a list

val init : int -> (int -> 'a') -> 'a list

val append : 'a list -> 'a list -> 'a list

val rev_append : 'a list -> 'a list -> 'a list

val concat : 'a list list -> 'a list

val flatten = concat
```

대부분이 이름과 타입만 봐도 동작을 알 수 있다.
 * `cons`는 중위 연산자 `::`이다.
 * `List.init len f`는 `[f 0; f 1; ...; f (len-1)]`과 같고 왼쪽에서부터 평가된다.
 * `append`는 중위 연산자 `@`이며, *꼬리 재귀가 아니다*. 반면 `rev_append`는 `List.rev l1 @ l2`와 의미가 동일하지만 **꼬리 재귀**이며 따라서 더 효율적이다. 이로 인해서 두 리스트를 합칠 때는 첫 번째 리스트를 *뒤집어서* `rev_append`를 하는 전략을 고민해봐야 한다.
 * `concat`과 `flatten`은 같은 동작을 하며, *꼬리 재귀가 아니다*. 그래서 리스트의 리스트를 펴는 작업은 큰 입력이 예상될 때 되도록 하지 않는 것이 좋다.
