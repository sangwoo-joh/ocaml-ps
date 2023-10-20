# Reading Inputs

## Integer Input

 정수를 입력받는 방법은 크게 두 가지가 있다.

 참고로 OCaml의 기본 `int` 타입은 32비트도 64비트도 아닌 63비트로 -461경에서 461경
 사이의 값을 표현할 수 있다. 정말 64비트, -922경~922경 정도의 범위가 필요한
 문제가 아니라면 웬만해서는 내장 `int` 타입으로 다 커버 가능하다.

### `read_int`

 먼저 [표준 입력에 대한 입력 함수](https://v2.ocaml.org/releases/4.11/htmlman/libref/Stdlib.html#2_Inputfunctionsonstandardinput)를 사용하는 방법이다.

```ocaml
val read_int : unit -> int
```

 가장 쉬운 방법은 `read_int`를 쓰는 거다. OCaml 정수 (즉, 63비트) 하나를
 읽어들인다. 하지만 구체적인 포매팅을 못하기 때문에 입력이 많거나 복잡한
 문제에서 썼다가는 런타임 에러를 만날 확률이 높아진다. 입력이 1~2개로 끝나는
 경우에 주로 쓴다.

### `Scanf.scanf`

 사실 OCaml은 그 자체로 C 런타임[^1]이므로 C에서 쓰이는 방법들을 모두 사용할 수
 있다. 그 중에서도 C의 `scanf`를 바인딩해둔 `Scanf.scanf`를 쓰면 된다.


```ocaml
let input = Scanf.scanf "%d " (fun x -> x) ;;
```

 아래 코드와 의미적으로 동일하다:

```cpp
int x;
scanf("%d ", &x);
```

 입력 여러 개를 한 번에 받을 수도 있다.

```ocaml
let a, b = Scanf.scanf "%d %d" (fun x y -> x y);;
```

 포맷 스트링의 개수만큼 함수 인자가 늘어난다고 생각하면 된다. OCaml의
 [`Scanf.scanf`](https://v2.ocaml.org/releases/4.11/htmlman/libref/Scanf.html#1_Specialisedformattedinputfunctions) 타입은 엉망진창이기 때문에 이해하려고 시도하지 않는게 좋다.


## String Input

 문자열 입력도 비슷하다.

### `read_line`

```ocaml
val read_line : unit -> string
```

 뉴라인을 만날 때까지 입력 한 줄을 통째로 받는다. 공백도 포함한다. 마지막 뉴라인
 문자는 알아서 잘라준다.

 보통 입력을 이렇게 한 줄 받으면 공백이나 컴마를 기준으로 자르는 등의 후처리가
 필요한 경우가 많다. 이럴땐 다음 함수를 쓰면 된다.

```ocaml
val String.split_on_char : char -> string -> stirng list
```

 즉, `String.split_on_char sep (read_line ())` 하면 한 줄을 읽어들인 다음 `sep`을
 기준으로 문자열을 잘라서 문자열 리스트로 돌려준다. 문자열이나 트리 관련
 문제에서 쓰인다.

### `Scanf.scanf`

 `read_line`은 아래 코드와 완전히 동일하다.

```ocaml
Scanf.scanf "%[^\n]"
```

 `[ ]`안의 정규식으로 입력을 지정할 수 있고 여기에 `^\n`를 해줘서 뉴라인 빼고 전부
 다 읽어들이게 하면 된다. 단, 정규식 엔진을 돌려야 하기 때문에 `read_line` 보다는
 느리다.


---

[^1]: 그래서 성능도 꽤 좋은편이다; 실제로 백준의 언어 탭에 가보면 자바나 파이썬처럼
 채점 시 시간 제한은 없고 메모리만 32MB 더 얹어준다.
