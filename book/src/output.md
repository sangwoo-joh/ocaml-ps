# Output

## `print_xxx` 계열

```ocaml
val print_char : char -> unit

val print_string : string -> unit

val print_bytes : bytes -> unit

val print_int : int -> unit

val print_float : float -> unit
```

 위의 함수들을 타입에 맞게 적절히 사용하면 된다

 단, 아래 두 함수는 주의해야 한다.

```ocaml
val print_endline : string -> unit

val print_newline : unit -> unit
```

 `print_endline`과 `print_newline`은 모두 뉴라인과 관련이 있는 출력 함수인데,
 그것보다 중요한 것은 두 함수는 모두 문자열을 표준 출력에 뿌린 다음 **표준 출력을
 비운다(flush)**. 그래서 문제의 조건에 따라 엄청나게 많은 출력을 해야하는 경우
 출력에 `print_endline` 을 쓰면 *시간 초과*가 뜬다.

 반면에 위의 `print_<primitive-type>` 함수나, 아니면 아예 C 스타일의 `Printf.printf
 "%..."` 같은 포맷스트링 출력 함수의 경우 적절한 버퍼링을 관리하여 매번 표준
 출력을 Flush하지 않기 때문에 출력이 많은 경우에 훨씬 더 효율적이다.


### 예시

 [수 찾기](https://www.acmicpc.net/problem/1920) 문제의 경우 핵심 알고리즘 자체는 정렬 후 이분탐색을 하거나 해시
 테이블을 이용해서 검색을 빠르게 할 수 있다. 문제는 출력인데, 조건에 따라 `M`의
 크기가 \\( 1 \leq M \leq 100,000 \\) 이라서 최대 10만번의 출력을 해야한다. 이 경우
 각 줄의 답을 `print_endline `으로 출력하면 [시간 초과](http://boj.kr/3595e7aea72f4404b2f9457d7463f0a5)가 뜨고, `print_string` 을
 이용하면 [정답](http://boj.kr/163afb6ef1574f2f9e5aef070fc3b213)이 된다.
