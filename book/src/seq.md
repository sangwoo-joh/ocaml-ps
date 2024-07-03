# Seq

`Seq`(시퀀스)는 OCaml의 특이한 데이터 구조 중 하나로, **지연 계산 리스트(delayed list)**이다. 즉, 다음 원소에 접근하려면 어떤 계산(평가)가 필요한 리스트이다. 이로 인해 *무한한 시퀀스*를 만들 수 있고, 순회하면서 시퀀스를 만들 수 있고, 미리 변환하지 않고 지연된 방식으로 시퀀스를 변환할 수 있다.

```ocaml
type 'a t = unit -> 'a node
```
 * `'a` 타입 원소를 담은 지연 계산 리스트의 타입이다. 구체화된 리스트의 노드 `'a node`는 `lazy` 블록이 아니라 *클로져*에 의해서 지연 계산되므로, 여기에 접근할 때마다 다시 계산될 수 있다.

```ocaml
type 'a node =
  | Nil
  | Cons of 'a * 'a t
```
 * 계산 완료된 리스트의 노드로, 비어있거나 하나의 원소와 지연된 꼬리를 담고 있다.

## 기본 연산

```ocaml
val empty : 'a t

val return : 'a -> 'a t

val cons : 'a -> 'a t -> 'a t

val append : 'a t -> 'a t -> 'a t

val map : ('a -> 'b) -> 'a t -> 'b t

val filter : ('a -> bool) -> 'a t -> 'a t

val filter_map : ('a -> 'b option) -> 'a t -> 'b t

val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a

val iter : ('a -> unit) -> 'a t -> unit

val unfold : ('b -> ('a * 'b) option) -> 'b -> 'a t
```

`return`을 제외한 나머지는 거진 다 리스트와 동일하다.

`unfold`가 좀 특이한데, 어떤 스텝 함수와 초기값으로부터 시퀀스를 만드는 함수이다. `unfold f u`를 호출하면, `f u`가 `None`이면 `empty`를 리턴하고, `f u`가 `Some (x, y)` 이면 `Cons (x, unfold f y)`를 리턴한다.
