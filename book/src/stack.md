# Stack

LIFO 스택으로, OCaml의 스택은 mutable list로 구현되어 제자리 수정(in-place
modification)을 한다.

## 기본 연산

```ocaml
type 'a t

exception Empty

val create : unit -> 'a t

val push : 'a -> 'a t -> unit

val pop : 'a t -> 'a

val pop_opt : 'a t -> 'a option

val top : 'a t -> 'a

val top_opt : 'a t -> 'a option

val clear : 'a t -> unit

val copy : 'a t -> 'a t

val is_empty : 'a t -> bool

val length : 'a t -> int

val iter : ('a -> unit) -> 'a t -> unit

val fold : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b
```

기본 연산은 함수 이름을 보면 대충 알 수 있다. 스택은 가변 리스트로 구현되어 있기 때문에 `create` 을 통해서 만들어야 하고, 대입 연산은 얕은 복사만 하기 때문에 깊은 복사를 하려면 `copy`를 호출해야 한다.

## 이터레이터

```ocaml
val to_seq : 'a t -> 'a Seq.t

val add_seq : 'a t -> 'a Seq.t -> unit

val of_seq : 'a Seq.t -> 'a t
```
