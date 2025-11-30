# 다이얼로그 및 알림 위젯 클래스

## CustomDialog

AlertDialog를 간편하게 표시하는 헬퍼 클래스입니다.

### 기본 사용법

```dart
CustomDialog.show(
  context,
  title: "알림",
  message: "메시지입니다",
)
```

### 주요 메서드

#### `show`

다이얼로그를 표시하는 정적 메서드입니다.

**파라미터:**

| 파라미터             | 타입                | 기본값                     | 설명                                   |
| -------------------- | ------------------- | -------------------------- | -------------------------------------- |
| `context`            | `BuildContext`      | 필수                       | BuildContext                           |
| `title`              | `dynamic`           | 필수                       | 다이얼로그 제목 (String 또는 Widget)   |
| `message`            | `dynamic`           | 필수                       | 다이얼로그 메시지 (String 또는 Widget) |
| `type`               | `DialogType`        | `DialogType.single`        | 다이얼로그 타입                        |
| `confirmText`        | `String`            | "확인"                     | 확인 버튼 텍스트                       |
| `cancelText`         | `String`            | "취소"                     | 취소 버튼 텍스트                       |
| `onConfirm`          | `VoidCallback?`     | `null`                     | 확인 버튼 클릭 시 콜백                 |
| `onCancel`           | `VoidCallback?`     | `null`                     | 취소 버튼 클릭 시 콜백                 |
| `barrierDismissible` | `bool`              | `false`                    | 배경 탭으로 닫기 가능 여부             |
| `backgroundColor`    | `Color?`            | `Colors.white`             | 다이얼로그 배경색                      |
| `borderRadius`       | `double?`           | `null`                     | 다이얼로그 모서리 둥글기               |
| `actionsAlignment`   | `MainAxisAlignment` | `MainAxisAlignment.center` | 버튼 정렬 방식                         |

### DialogType

- `DialogType.single`: 확인 버튼만 있는 다이얼로그
- `DialogType.dual`: 확인/취소 버튼이 있는 다이얼로그

### 사용 예시

```dart
// 단일 버튼 다이얼로그 (String)
CustomDialog.show(
  context,
  title: "알림",
  message: "작업이 완료되었습니다.",
  type: DialogType.single,
)

// 이중 버튼 다이얼로그
CustomDialog.show(
  context,
  title: "확인",
  message: "진행하시겠습니까?",
  type: DialogType.dual,
  onConfirm: () {
    print("확인 버튼 클릭");
  },
  onCancel: () {
    print("취소 버튼 클릭");
  },
)

// Widget 사용
CustomDialog.show(
  context,
  title: Row(
    children: [
      Icon(Icons.info, color: Colors.blue),
      SizedBox(width: 8),
      Text("정보"),
    ],
  ),
  message: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text("이것은 Widget을 사용한 다이얼로그입니다."),
      SizedBox(height: 8),
      Text("제목과 메시지 모두 Widget으로 지정할 수 있습니다."),
    ],
  ),
  type: DialogType.single,
)

// 버튼 정렬
CustomDialog.show(
  context,
  title: "정렬 예시",
  message: "버튼이 왼쪽 정렬됩니다.",
  type: DialogType.dual,
  actionsAlignment: MainAxisAlignment.start,
)
```

---

## CustomSnackBar

SnackBar를 간편하게 표시하는 헬퍼 클래스입니다.

### 주요 메서드

#### `show`

SnackBar를 표시하는 정적 메서드입니다.

**파라미터:**

| 파라미터          | 타입               | 기본값                   | 설명                        |
| ----------------- | ------------------ | ------------------------ | --------------------------- |
| `context`         | `BuildContext`     | 필수                     | BuildContext                |
| `message`         | `dynamic`          | 필수                     | 메시지 (String 또는 Widget) |
| `actionLabel`     | `String?`          | `null`                   | 액션 버튼 라벨              |
| `onAction`        | `VoidCallback?`    | `null`                   | 액션 버튼 클릭 시 콜백      |
| `duration`        | `Duration`         | `Duration(seconds: 3)`   | 표시 시간                   |
| `backgroundColor` | `Color?`           | `Colors.grey.shade800`   | 배경색                      |
| `textColor`       | `Color?`           | `Colors.white`           | 텍스트 색상 (String인 경우) |
| `behavior`        | `SnackBarBehavior` | `SnackBarBehavior.fixed` | SnackBar 동작 방식          |

#### `showSuccess`

성공 메시지를 표시하는 메서드 (녹색 배경)

#### `showError`

에러 메시지를 표시하는 메서드 (빨간색 배경)

#### `showWarning`

경고 메시지를 표시하는 메서드 (주황색 배경)

#### `showInfo`

정보 메시지를 표시하는 메서드 (파란색 배경)

### 사용 예시

```dart
// 기본 사용 (String)
CustomSnackBar.show(
  context,
  message: "기본 SnackBar 메시지입니다.",
)

// 성공 메시지
CustomSnackBar.showSuccess(
  context,
  message: "작업이 성공적으로 완료되었습니다!",
)

// 에러 메시지
CustomSnackBar.showError(
  context,
  message: "에러가 발생했습니다. 다시 시도해주세요.",
)

// 경고 메시지
CustomSnackBar.showWarning(
  context,
  message: "주의가 필요한 상황입니다.",
)

// 정보 메시지
CustomSnackBar.showInfo(
  context,
  message: "이것은 정보 메시지입니다.",
)

// 액션 버튼 포함
CustomSnackBar.show(
  context,
  message: "메시지를 삭제하시겠습니까?",
  actionLabel: "실행",
  onAction: () {
    print("삭제 실행");
  },
)

// Widget 사용
CustomSnackBar.show(
  context,
  message: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle, color: Colors.white),
      SizedBox(width: 8),
      Text("성공적으로 완료되었습니다!", style: TextStyle(color: Colors.white)),
    ],
  ),
  backgroundColor: Colors.green,
)
```

---

## CustomActionSheet

ActionSheet를 간편하게 표시하는 헬퍼 클래스입니다.

### 주요 메서드

#### `show`

ActionSheet를 표시하는 정적 메서드입니다.

**파라미터:**

| 파라미터          | 타입                    | 기본값         | 설명                |
| ----------------- | ----------------------- | -------------- | ------------------- |
| `context`         | `BuildContext`          | 필수           | BuildContext        |
| `title`           | `String?`               | `null`         | 제목                |
| `message`         | `String?`               | `null`         | 메시지              |
| `items`           | `List<ActionSheetItem>` | 필수           | 액션 항목 리스트    |
| `showCancel`      | `bool`                  | `true`         | 취소 버튼 표시 여부 |
| `cancelText`      | `String`                | "취소"         | 취소 버튼 텍스트    |
| `backgroundColor` | `Color?`                | `Colors.white` | 배경색              |
| `borderRadius`    | `double?`               | `20`           | 모서리 둥글기       |

#### `showSimple`

간단한 액션시트를 표시하는 메서드 (라벨만 있는 경우)

**파라미터:**

| 파라미터     | 타입                 | 기본값 | 설명                             |
| ------------ | -------------------- | ------ | -------------------------------- |
| `context`    | `BuildContext`       | 필수   | BuildContext                     |
| `labels`     | `List<String>`       | 필수   | 라벨 리스트                      |
| `callbacks`  | `List<VoidCallback>` | 필수   | 콜백 리스트 (labels와 개수 동일) |
| `title`      | `String?`            | `null` | 제목                             |
| `showCancel` | `bool`               | `true` | 취소 버튼 표시 여부              |
| `cancelText` | `String`             | "취소" | 취소 버튼 텍스트                 |

### ActionSheetItem 속성

| 속성            | 타입            | 기본값         | 설명                                              |
| --------------- | --------------- | -------------- | ------------------------------------------------- |
| `label`         | `dynamic`       | 필수           | 액션 항목의 텍스트 또는 위젯 (String 또는 Widget) |
| `icon`          | `IconData?`     | `null`         | 액션 항목의 아이콘                                |
| `textColor`     | `Color?`        | `Colors.black` | 액션 항목의 텍스트 색상                           |
| `onTap`         | `VoidCallback?` | `null`         | 액션 항목 클릭 시 실행될 콜백                     |
| `isDestructive` | `bool`          | `false`        | 위험한 작업 여부 (true일 경우 빨간색 표시)        |

### 사용 예시

```dart
// 기본 사용 (String)
CustomActionSheet.show(
  context,
  title: "선택하세요",
  items: [
    ActionSheetItem(
      label: "옵션 1",
      icon: Icons.check_circle,
      onTap: () {
        print("옵션 1 선택");
      },
    ),
    ActionSheetItem(
      label: "옵션 2",
      icon: Icons.favorite,
      onTap: () {
        print("옵션 2 선택");
      },
    ),
  ],
)

// 위험 작업 포함
CustomActionSheet.show(
  context,
  title: "계정 관리",
  items: [
    ActionSheetItem(
      label: "프로필 수정",
      icon: Icons.edit,
      onTap: () {},
    ),
    ActionSheetItem(
      label: "계정 삭제",
      icon: Icons.delete,
      isDestructive: true,
      onTap: () {
        print("계정 삭제");
      },
    ),
  ],
)

// Widget 사용
CustomActionSheet.show(
  context,
  title: "선택하세요",
  items: [
    ActionSheetItem(
      label: Row(
        children: [
          Icon(Icons.edit, color: Colors.blue),
          SizedBox(width: 8),
          Text("수정"),
        ],
      ),
      onTap: () {
        print("수정 선택");
      },
    ),
    ActionSheetItem(
      label: Row(
        children: [
          Icon(Icons.delete, color: Colors.red),
          SizedBox(width: 8),
          Text("삭제", style: TextStyle(color: Colors.red)),
        ],
      ),
      isDestructive: true,
      onTap: () {
        print("삭제 선택");
      },
    ),
  ],
)

// 간단한 사용
CustomActionSheet.showSimple(
  context,
  title: "색상 선택",
  labels: ["빨강", "파랑", "초록"],
  callbacks: [
    () => print("빨강 선택"),
    () => print("파랑 선택"),
    () => print("초록 선택"),
  ],
)
```
