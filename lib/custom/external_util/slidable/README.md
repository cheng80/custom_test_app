# CustomSlidable 사용 가이드

슬라이더블 액션을 쉽게 사용할 수 있도록 래핑한 커스텀 위젯입니다.

## 주요 기능

- ✅ 한 번에 하나의 슬라이더블만 열리도록 자동 관리
- ✅ 페이지 진입/나갈 때 열린 슬라이더블 자동 닫기
- ✅ 컨트롤러 자동 관리 (생성, 동기화, 정리)
- ✅ groupTag 자동 설정
- ✅ SlidableAutoCloseBehavior 자동 적용

## 기본 사용법

### 1. StatefulWidget에 TickerProviderStateMixin 추가

```dart
class MyWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> 
    with TickerProviderStateMixin {
  // ...
}
```

### 2. CustomSlidableList로 리스트 감싸기

```dart
CustomSlidableList<Todo>(
  items: todos,
  getId: (todo) => todo.id!,
  vsync: this, // TickerProviderStateMixin 필요
  itemBuilder: (context, todo, index) {
    return CustomSlidable(
      id: todo.id!,
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              // 모든 슬라이더블 닫기
              await CustomSlidableList.closeAll(context);
              // 액션 처리
              // ...
            },
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            label: '수정',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await CustomSlidableList.closeAll(context);
              // 액션 처리
              // ...
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: '삭제',
          ),
        ],
      ),
      child: TodoCard(todo), // 카드 위젯
    );
  },
  child: CustomListView(
    itemCount: todos.length,
    itemBuilder: (context, index) {
      // itemBuilder는 CustomSlidableList의 itemBuilder를 사용
      return const SizedBox.shrink();
    },
  ),
)
```

### 3. 간단한 사용 예시

```dart
// 기존 코드
CustomListView(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return Slidable(
      startActionPane: ActionPane(...),
      child: TodoCard(todos[index]),
    );
  },
)

// CustomSlidable 사용
CustomSlidableList<Todo>(
  items: todos,
  getId: (todo) => todo.id!,
  vsync: this,
  itemBuilder: (context, todo, index) {
    return CustomSlidable(
      id: todo.id!,
      startActionPane: ActionPane(...),
      child: TodoCard(todo),
    );
  },
  child: CustomListView(
    itemCount: todos.length,
    itemBuilder: (context, index) => const SizedBox.shrink(),
  ),
)
```

## 주요 클래스

### SlidableListController

슬라이더블 컨트롤러들을 관리하는 클래스입니다.

```dart
final controller = SlidableListController(
  vsync: this,
  groupTag: 'my_slidable_group', // 선택적
);

// 모든 슬라이더블 닫기
await controller.closeAll();

// 컨트롤러 정리
controller.dispose();
```

### CustomSlidable

개별 슬라이더블 위젯입니다. `CustomSlidableList` 내부에서 사용하면 자동으로 컨트롤러를 가져옵니다.

```dart
CustomSlidable(
  id: todo.id!,
  startActionPane: ActionPane(...),
  endActionPane: ActionPane(...),
  child: TodoCard(todo),
)
```

### CustomSlidableList

슬라이더블 리스트를 관리하는 위젯입니다.

```dart
CustomSlidableList<T>(
  items: items,
  getId: (item) => item.id!,
  vsync: this,
  itemBuilder: (context, item, index) => CustomSlidable(...),
  child: ListView(...),
)
```

## 주의사항

1. **TickerProviderStateMixin 필수**: `CustomSlidableList`를 사용하려면 State 클래스에 `TickerProviderStateMixin`을 추가해야 합니다.

2. **ID 필수**: 각 아이템은 고유한 `int` 타입의 ID를 가져야 합니다.

3. **itemBuilder와 child**: `itemBuilder`는 `CustomSlidable`을 반환하고, `child`는 실제 리스트 위젯입니다. `child`의 `itemBuilder`는 사용되지 않으므로 빈 위젯을 반환해도 됩니다.

4. **액션 실행 전 닫기**: 액션을 실행하기 전에 `CustomSlidableList.closeAll(context)`를 호출하여 모든 슬라이더블을 닫아야 합니다.

## 마이그레이션 가이드

기존 코드에서 마이그레이션하는 방법:

1. State 클래스에 `TickerProviderStateMixin` 추가
2. `Slidable`을 `CustomSlidable`로 변경
3. 리스트를 `CustomSlidableList`로 감싸기
4. 액션 실행 전에 `CustomSlidableList.closeAll(context)` 호출 추가
