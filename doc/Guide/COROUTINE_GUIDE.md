# Unity 코루틴 vs Dart 비동기 프로그래밍

Unity의 코루틴과 Dart의 비동기 프로그래밍을 비교하고, 유사한 기능을 구현하는 방법을 설명합니다.

## Unity 코루틴의 특징

Unity 코루틴은 다음과 같은 특징이 있습니다:

```csharp
IEnumerator MyCoroutine()
{
    // 즉시 실행
    Debug.Log("시작");

    // 다음 프레임까지 대기
    yield return null;

    // 2초 대기
    yield return new WaitForSeconds(2);
    Debug.Log("2초 후");

    // 조건 만족까지 대기
    yield return new WaitUntil(() => someCondition);

    // 다른 코루틴 실행
    yield return StartCoroutine(OtherCoroutine());

    Debug.Log("완료");
}
```

## Dart의 비동기 프로그래밍

Dart에서는 `async/await`와 `Future`를 사용하여 유사한 기능을 구현할 수 있습니다.

### 기본 비교

| Unity 코루틴                                  | Dart                                                             |
| --------------------------------------------- | ---------------------------------------------------------------- |
| `yield return null`                           | `await Future.delayed(Duration.zero)` 또는 `await Future(() {})` |
| `yield return new WaitForSeconds(2)`          | `await Future.delayed(Duration(seconds: 2))`                     |
| `yield return new WaitUntil(() => condition)` | `await _waitUntil(() => condition)` (직접 구현 필요)             |
| `yield return StartCoroutine(other)`          | `await otherCoroutine()`                                         |

### 기본 사용법

```dart
// Unity 코루틴과 유사한 Dart 코드
Future<void> myCoroutine() async {
  // 즉시 실행
  print("시작");

  // 다음 프레임까지 대기 (거의 즉시)
  await Future.delayed(Duration.zero);

  // 2초 대기
  await Future.delayed(Duration(seconds: 2));
  print("2초 후");

  // 조건 만족까지 대기
  await waitUntil(() => someCondition);

  // 다른 코루틴 실행
  await otherCoroutine();

  print("완료");
}
```

## Dart에서 코루틴 유사 기능 구현

### 1. 기본 지연 (WaitForSeconds)

```dart
// Unity: yield return new WaitForSeconds(2);
Future<void> waitForSeconds(double seconds) async {
  await Future.delayed(Duration(milliseconds: (seconds * 1000).toInt()));
}

// 사용 예시
Future<void> example() async {
  print("시작");
  await waitForSeconds(2.0);
  print("2초 후");
}
```

### 2. 조건 만족까지 대기 (WaitUntil)

```dart
// Unity: yield return new WaitUntil(() => condition);
Future<void> waitUntil(bool Function() condition, {Duration checkInterval = const Duration(milliseconds: 100)}) async {
  while (!condition()) {
    await Future.delayed(checkInterval);
  }
}

// 사용 예시
bool isReady = false;

Future<void> example() async {
  // 3초 후 isReady를 true로 설정
  Future.delayed(Duration(seconds: 3), () {
    isReady = true;
  });

  print("대기 중...");
  await waitUntil(() => isReady);
  print("준비 완료!");
}
```

### 3. 다음 프레임까지 대기 (yield return null)

```dart
// Unity: yield return null;
Future<void> waitForNextFrame() async {
  await Future.delayed(Duration.zero);
  // 또는
  // await Future(() {});
}

// 사용 예시
Future<void> example() async {
  print("프레임 1");
  await waitForNextFrame();
  print("프레임 2");
}
```

### 4. 여러 조건 중 하나 만족까지 대기 (WaitUntilAny)

```dart
Future<void> waitUntilAny(List<bool Function()> conditions, {Duration checkInterval = const Duration(milliseconds: 100)}) async {
  while (true) {
    for (final condition in conditions) {
      if (condition()) {
        return;
      }
    }
    await Future.delayed(checkInterval);
  }
}
```

### 5. 여러 조건 모두 만족까지 대기 (WaitUntilAll)

```dart
Future<void> waitUntilAll(List<bool Function()> conditions, {Duration checkInterval = const Duration(milliseconds: 100)}) async {
  while (true) {
    bool allSatisfied = true;
    for (final condition in conditions) {
      if (!condition()) {
        allSatisfied = false;
        break;
      }
    }
    if (allSatisfied) return;
    await Future.delayed(checkInterval);
  }
}
```

### 6. 반복 실행 (While 조건)

```dart
// Unity: while (condition) { yield return null; }
Future<void> waitWhile(bool Function() condition, {Duration checkInterval = const Duration(milliseconds: 100)}) async {
  while (condition()) {
    await Future.delayed(checkInterval);
  }
}
```

### 7. 코루틴 체이닝

```dart
// Unity: yield return StartCoroutine(otherCoroutine());
Future<void> coroutine1() async {
  print("코루틴 1 시작");
  await Future.delayed(Duration(seconds: 1));
  await coroutine2(); // 다른 코루틴 실행
  print("코루틴 1 완료");
}

Future<void> coroutine2() async {
  print("코루틴 2 시작");
  await Future.delayed(Duration(seconds: 1));
  print("코루틴 2 완료");
}
```

## Flutter에서의 활용

### 위젯 업데이트와 함께 사용

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int counter = 0;

  Future<void> countCoroutine() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        counter++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('카운터: $counter'),
        ElevatedButton(
          onPressed: countCoroutine,
          child: Text('시작'),
        ),
      ],
    );
  }
}
```

### 애니메이션과 함께 사용

```dart
Future<void> fadeInCoroutine() async {
  double opacity = 0.0;

  while (opacity < 1.0) {
    await Future.delayed(Duration(milliseconds: 16)); // ~60fps
    setState(() {
      opacity += 0.05;
    });
  }
}
```

## 실제 사용 예시

### 예시 1: 순차적 작업

```dart
Future<void> sequentialTasks() async {
  print("작업 1 시작");
  await Future.delayed(Duration(seconds: 1));
  print("작업 1 완료");

  print("작업 2 시작");
  await Future.delayed(Duration(seconds: 1));
  print("작업 2 완료");

  print("작업 3 시작");
  await Future.delayed(Duration(seconds: 1));
  print("작업 3 완료");
}
```

### 예시 2: 조건부 대기

```dart
bool isLoading = false;
bool isDataReady = false;

Future<void> loadDataCoroutine() async {
  isLoading = true;

  // 데이터 로드 시뮬레이션
  Future.delayed(Duration(seconds: 2), () {
    isDataReady = true;
  });

  // 데이터 준비될 때까지 대기
  await waitUntil(() => isDataReady);

  isLoading = false;
  print("데이터 로드 완료");
}
```

### 예시 3: 반복 작업

```dart
Future<void> repeatUntilCondition() async {
  int attempts = 0;

  await waitUntil(() {
    attempts++;
    print("시도 $attempts");
    return attempts >= 5; // 5번 시도 후 종료
  });

  print("완료");
}
```

## 주요 차이점

### Unity 코루틴

- 프레임 기반 실행
- `yield return`으로 제어권 반환
- MonoBehaviour에 종속적
- 게임 루프와 통합

### Dart 비동기

- 이벤트 루프 기반
- `await`로 비동기 작업 대기
- 독립적인 비동기 함수
- Flutter 프레임워크와 통합

## 권장사항

1. **간단한 지연**: `Future.delayed` 직접 사용
2. **조건 대기**: `waitUntil` 헬퍼 함수 사용
3. **복잡한 로직**: `async/await`로 순차적 작성
4. **반복 작업**: `Stream` 또는 `Timer` 고려
5. **위젯 업데이트**: `setState`와 함께 사용

## 결론

Dart에서는 Unity의 코루틴과 완전히 동일한 문법은 없지만, `async/await`와 `Future`를 사용하여 유사한 기능을 구현할 수 있습니다. Unity의 `yield return` 대신 Dart의 `await`를 사용하면 됩니다.
