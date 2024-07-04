# Queue

```ocaml
type 'a t

exception Empty

val create : unit -> 'a t

val add : 'a -> 'a t -> unit

val push : 'a -> 'a t -> unit

val take : 'a t -> 'a

val take_opt : 'a t -> 'a option

val pop : 'a t -> 'a

val peek : 'a t -> 'a

val peek_opt : 'a t -> 'a option

val top : 'a t -> 'a

val clear : 'a t -> unit

val copy : 'a t -> 'a t

val is_empty : 'a t -> bool

val length : 'a t -> int

val iter : ('a -> unit) -> 'a t -> unit

val fold : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b

val transfer : 'a t -> 'a t -> unit

val to_seq : 'a t -> 'a Seq.t

val add_seq : 'a t -> 'a Seq.t -> unit

val of_seq : 'a Seq.t -> 'a t
```

이름과 타입만 보면 대충 알 수 있다. 한 가지 문제점은 이게 단방향 큐라는 점이다. 문제에 따라서는 덱(Deque)이 필요할 수도 있는데, 그런 경우에는 직접 구현하는 수 밖에 없다.

## 가변 셀
덱을 구현하는 한 가지 방법은 일반적인 imperative에서 하는 것과 마찬가지로 두 개의 포인터와 사이즈 변수를 이용해서 링크드 리스트 기반의 환형 큐를 만드는 것이다. 이렇게 하면 원래의 `Queue` 모듈이랑 비슷하게 가변 데이터 구조를 구현한 것이다.

```ocaml
module Deque = struct
  exception Empty

  type 'a cell =
    | Nil
    | Cons of { content: 'a; mutable next: 'a cell }

  type 'a t = {
    mutable length: int ;
    mutable first: 'a cell ;
    mutable last: 'a cell
  }

  let create () = { length= 0; first= Nil; last= Nil }

  let clear q =
    q.length <- 0;
    q.first <- Nil;
    q.last <- Nil

  let add x q =
    let cell = Cons { content= x; next= Nil } in
    match q.last with
    | Nil ->
      q.length <- 1;
      q.first <- cell;
      q.last <- cell
    | Cons last ->
      q.length <- q.length + 1;
      last.next <- cell;
      q.last <- cell

  let push = add

  let head q =
    match q.first with
    | Nil -> raise Empty
    | Cons {content} -> content

  let take q =
    match q.first with
    | Nil -> raise Empty
    | Cons {content; next= Nil} ->
      clear q;
      content
    | Cons {content; next} ->
      q.length <- q.length - 1;
      q.first <- next;
      content

  let pop = take

  let tail q =
    match q.last with
    | Nil -> raise Empty
    | Cons {content} -> content

  let is_empty q = q.length = 0

  let length q = q.length
end
```


번외로 리스트(스택) 두 개를 이용해서 armotized 복잡도로 큐를 구현할 수도 있는데, 이 구현으로 덱을 구현하면 문제의 상황에 따라서 복잡도가 널뛸 수 있으므로 추천하지 않는다. (예를 들어, 아주 많은 원소를 집어넣은 다음 `head`, `tail`을 반복하면 리스트가 계속적으로 뒤집혀서 왔다갔다 해야하므로 O(N)의 복잡도가 꾸준히 소요되어서 armotization이 동작하지 않는다)
