# Garbage Collection

OCaml은 Generational Hypothesis에 기반한 Generational Mark and Sweep Garbage Collection을 기반으로 메모리를 관리한다. 그래서 (특히 기본 정수의) 메모리 표현이 조금 특이한데 자세한 내용은 [Memory Representation of Values](https://dev.realworldocaml.org/runtime-memory-layout.html)와 [Understanding the Garbage Collector](https://dev.realworldocaml.org/garbage-collector.html)를 참조하는 것이 가장 좋다. 여기서는 짧게 몇 가지만 언급하려고 한다.

## 힙의 종류
### 마이너 힙
가장 빠르다. 대부분의 메모리 블록은 제일 처음 마이너 힙에 할당되고 마이너 힙이 넘치는 순간 마이너 컬렉션이 수행되면서 살아남은 애들이 메이저 힙으로 프로모션 되는 방식이다. 마이너 힙은 Bump Pointer 방식으로 할당되기 때문에 빠르다. 그래서 마이너 힙이 클수록 작은 문제에서는 잘 동작할지도 모른다. 하지만 마이너 힙에서 살아남은 블록들이 메이저 힙으로 프로모션 될 때에는 이 블록들을 모두 **복사**하기 때문에 성능이 튈 수도 있다.

### 메이저 힙
복잡하거나 큰 데이터들은 대부분 처음부터 메이저 힙에 올라간다. 메이저 힙 컬렉션은 (1) 마킹 (2) 스윕 (3) 압축 세 페이즈가 있고, 성능을 위해서 각각을 조금씩 잘라서(slice) 동작하기 때문에 메모리 사용량이 항상 실제보다 조금 더 많을 수 밖에 없다. 문제에서 예상되는 입력이 커서 메이저 힙을 사용할 수 밖에 없는 경우 아예 처음부터 메이저 힙 크기를 크게 잡아서 메이저 컬렉션을 수행하지 않는 방향으로 하는 것이 빠를지도 모른다.

## 메모리 할당 방식
메모리 할당 방식은 세 가지가 있다. (1) Best Fit, (2) Next Fit, (3) First Fit.

### Best Fit
두 가지 전략을 합친 할당 방식이다. 먼저, 작은 리스트나 튜플의 원소처럼, 대부분의 메이저 힙 할당이 작다는 관찰로부터 크기 별로 분류한 프리 리스트를 기반의 전략이 있다. 최대 16 워드 크기의 사이즈까지의 프리 리스트를 따로 구분해뒀다가 대부분의 할당에서 빠르게 제공한다.

두 번째 전략은, 더 큰 할당에 대해서 *스플레이 트리*라고 알려진 특별한 데이터 구조를 이용해서 프리 리스트를 구현한다. 이러한 검색 트리는 최근 접근 패턴에 알맞은 것으로, 가장 최근에 요청된 할당 사이즈에 가장 빠르게 접근할 수 있다는 의미이다.

크기 구분 프리 리스트에서 가능한 더 큰 사이즈가 없으면 작은 할당이 일어나고, 16 워드 이상의 큰 할당은 기본적으로 메인 프리 리스트에서 일어난다. 즉, 프리 리스트는 요청된 할당 크기만큼 큰 것 중 가장 작은 블록에 대해서 쿼리된다.

Best Fit은 기본 할당 방식으로 할당 비용 (CPU) 과 힙 파편화 사이에서 적절한 트레이드 오프를 보여준다.

### Next Fit

### First Fit



## Gc 모듈

Gc 모듈을 이용하면 Gc를 들여다보거나 조절하는 것이 가능하다. 먼저 현재 Gc 상태를 나타내는 `stat` 타입이 있다.

```ocaml
type stat = {
  minor_words: float;  (* 프로그램 시작 후부터 마이너 힙에 할당된 워드의 수 *)
  promoted_words: float;  (* 프로그램 시작 후부터 마이너 힙에 할당되어 마이너 컬렉션에서 살아남아서 메이저 힙으로 옮겨간 워드의 수 *)
  major_words: float;  (* 프로그램 시작 후부터 메이저 힙에 할당된 수로, 프로모트된 마이너 힙의 워드까지도 포함한다. *)
  minor_collections: int;  (* 프로그램 시작 이래 마이너 컬렉션 횟수 *)
  major_collections: int;  (* 프로그램 시작 이래 메이저 컬렉션 사이클 완료 횟수 *)
  heap_words: int;  (* 메이저 힙의 전체 크기 (워드) *)
  heap_chunks: int;  (* 메이저 힙을 구성하는 연속된 메모리 조각의 개수 *)
  live_words: int;  (* 메이저 힙에 살아있는 데이터의 워드 수 *)
  live_blocks: int;  (* 메이저 힙에 살아있는 블록 수 *)
  free_words: int;  (* 프리 리스트에 있는 워드 수 *)
  free_blocks: int;  (* 프리 리스트에 있는 블록 수 *)
  largest_free: int;  (* 프리 리스트에 있는 가장 큰 블록의 크기 (워드) *)
  fragments: int;  (* 단편화로 인해서 낭비되는 워드의 수. 할당에 쓸 수 없는 것으로, 두 개의 살아있는 블록 사이에 있는 1 워드 짜리 프리 블록들의 개수이다. *)
  compactions: int;  (* 프로그램 시작 이후 힙 압축 횟수 *)
  top_heap_words: int;  (* 메이저 힙에서 도달 가능한 최대 사이즈 (워드) *)
  stack_size: int;  (* 현재 스택 크기 (워드) *)
}
```

그리고 Gc에 쓰이는 다양한 파라미터들을 튜닝하기 위한 `control` 타입이 있다.

```ocaml
type control = {
  mutable minor_heap_size: int;
  mutable major_heap_increment: int;
  mutable space_overhead: int;
  mutable verbose: int;
  mutable max_overhead: int;
  mutable stack_limit: int;
  mutable allocation_policy: int;

  window_size: int;
  custom_major_ratio: int;
  custom_minor_ratio: int;
  custom_minor_max_size: int;
}
```

현재 `control` 설정 값은 `Gc.get ()`을 호출해서 알아낼 수 있다. 이 값을 튜닝하려면 `Gc.set { (Gc.get ()) with Gc.verbose = 0x00d }`와 같이 호출할 수 있다.

우리가 문제 풀이에서 관심있는 것은 `stat` 보다는 `control`이다. 각각의 값이 어떤 역할을 하는지 조금 더 살펴보자.
