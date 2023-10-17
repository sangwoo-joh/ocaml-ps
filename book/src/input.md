# Reading Inputs

 정수를 입력받는 방법은 몇 가지가 있다.

## `read_line`, `read_int`

 먼저 [표준 입력에 대한 입력 함수](https://v2.ocaml.org/releases/4.11/htmlman/libref/Stdlib.html#2_Inputfunctionsonstandardinput)를 사용하는 방법이다. 그 중에서도 다음 두 가지가
 널리 쓰인다

```ocaml
let input = read_int () ;; (* Single integer *)

let input = read_line () |> int_of_string ;;  (* Convert input string to int *)
```

 가장 쉬운 방법은 `read_int`를 쓰는 거다. OCaml 정수 (즉, 63비트) 하나를
 읽어들인다.

 혹은 입력의 한 줄이 정수 하나임이 보장된다면 `read_line`으로 줄을 읽어들인 다음
 정수로 변환하는 방법이 있다. 역시 63비트 OCaml 정수를 얻는다. 사실 이건
 `read_int`와 논리적으로 같을 뿐 아니라 아예 코드마저 같다. 실제로 표준 라이브러리
 코드를 뜯어보면 저렇게 구현되어 있다.

 모두 쉬운 방법이다. 하지만 원하는 포맷으로 읽어들이진 못하기 때문에 입력이
 많거나 복잡한 문제에서 썼다가는 런타임 에러를 만날 확률이 높아진다. 따라서 내가
 추천하는 방법은 다음 방법이다.

## `Scanf.scanf`

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



여기서


[^1]: 그래서 성능도 꽤 좋은편이다; 실제로 백준의 언어 탭에 가보면 자바나 파이썬처럼
 채점 시 시간 제한은 없고 메모리만 32MB 더 얹어준다.
