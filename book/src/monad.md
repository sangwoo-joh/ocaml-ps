# Monad

모나드는 뭐 카테고리 이론에서 빌려온 어쩌구.... 라고 배우면 겁먹고 이해하는데 실패한다.

모나드는 별게 아니라 *디자인 패턴*으로 받아들이면 좋다. 예를 들어, 패턴 매칭을 할 때 디폴트 패턴에 대해서 trivial한 작업만이 필요하고, 진짜 관심있는 데이터에 대해서는 많은 작업이 필요할 때, 모나드를 적용하면 코드가 깔끔해진다.

```ocaml
match foo y with
| Default -> ()
| Complex x -> ... very long long work for x ...
```

이런 코드가 있을 때, `bind`를 아래와 같이 정의하고

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

아래와 같이 할 수 있게 해주는게 바로 모나드이다.

```ocaml
foo y >>= fun x -> ... very long long work for x ...

(* or *)

let* x = foo y in
... very long long work for x ...
```
