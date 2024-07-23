# Monad

모나드를 뭐 카테고리 이론에서 빌려온 유서 깊은 어쩌구 저쩌구.... 이렇게 접근하면 겁먹고 이해하는데 실패한다.

모나드는 별게 아니라 *디자인 패턴*으로 접근하면 **사용하기** 좋다. 예를 들어, 패턴 매칭을 할 때 디폴트 패턴에 대해서 trivial한 작업만이 필요하고, 진짜 관심있는 데이터에 대해서는 많은 작업이 필요할 때, 모나드를 적용하면 코드가 깔끔해진다.

```ocaml
match foo y with
| Default -> ()
| Complex x -> ... very long long work for x ...
```

위와 같은 코드가 있을 때, `bind`를 아래와 같이 정의하고

```ocaml
let bind x f = match x with
  | Default -> ()
  | Complex x -> f x
```

중위 연산자 `>>=`, 또는 Let Syntax `let*`을 아래와 같이 정의하면

```ocaml
let ( >>= ) = bind

let ( let* ) = bind
```

원래 코드를 아래와 같이 깔끔하고 읽기 쉽게 만들어주는 문법 또는 디자인패턴이 바로 모나드라고 생각하면 된다.

```ocaml
foo y >>= fun x -> ... very long long work for x ...

(* or *)

let* x = foo y in
... very long long work for x ...
```

## Option Monad
가장 쉽고 직관 적인 예시로, Option 모듈에 있는 `bind`가 있다.

```ocaml
let bind o f = match o with None -> None | Some v -> f v
```

역시 이 `bind`를 `>>=` 또는 `let*` 으로 재정의해서 쓸 수 있다.

`bind`의 타입을 보면 좀더 이해하기 쉽다.

```ocaml
val bind : 'a option -> ('a -> 'b option) -> 'b option
```

즉 다음 두 가지 조건이 갖춰졌을 때, `bind` 모나드를 활용한다면 훨씬 코드를 읽기 수월해질 것이다. 어떤 옵션 값에 대해서,
 - 옵션이 `None` 일 때에는 아주 trivial한 작업, 여기서는 그냥 그대로 `None`을 흘려 보내는 일만이 필요하다.
 - 옵션의 실제 값 `Some v`에 대해서는, 안쪽 값 `v`를 가지고 이것저것 작업을 하고 최종적으로 *어떤 옵션 값*을 만들어내면
