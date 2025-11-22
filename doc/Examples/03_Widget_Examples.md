# Widget 사용 예제

String 대신 Widget을 사용하여 더 유연한 커스터마이징이 가능합니다.

## CustomButton - Widget 사용

### 아이콘 + 텍스트

```dart
CustomButton(
  btnText: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle, color: Colors.white, size: 20),
      SizedBox(width: 8),
      Text("확인", style: TextStyle(color: Colors.white)),
    ],
  ),
  backgroundColor: Colors.blue,
  onCallBack: () {
    print("확인 버튼 클릭");
  },
)
```

### 커스텀 스타일 텍스트

```dart
CustomButton(
  btnText: CustomText(
    "커스텀 버튼",
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  backgroundColor: Colors.purple,
  onCallBack: () {},
)
```

### 복잡한 레이아웃

```dart
CustomButton(
  btnText: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.download, color: Colors.white),
      SizedBox(height: 4),
      Text("다운로드", style: TextStyle(color: Colors.white)),
    ],
  ),
  backgroundColor: Colors.green,
  minimumSize: Size(120, 80),
  onCallBack: () {},
)
```

---

## CustomAppBar - Widget 사용

### 아이콘 + 텍스트

```dart
Scaffold(
  appBar: CustomAppBar(
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.home, color: Colors.white),
        SizedBox(width: 8),
        Text("홈", style: TextStyle(color: Colors.white)),
      ],
    ),
    backgroundColor: Colors.blue,
  ),
  body: Container(),
)
```

### 커스텀 텍스트 스타일

```dart
Scaffold(
  appBar: CustomAppBar(
    title: CustomText(
      "홈",
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.blue,
  ),
  body: Container(),
)
```

### 복잡한 레이아웃

```dart
Scaffold(
  appBar: CustomAppBar(
    title: Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 16, color: Colors.blue),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("홈", style: TextStyle(color: Colors.white, fontSize: 18)),
            Text("서브타이틀", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ],
    ),
    backgroundColor: Colors.blue,
  ),
  body: Container(),
)
```

---

## CustomDialog - Widget 사용

### 제목에 아이콘 포함

```dart
CustomDialog.show(
  context,
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.info, color: Colors.blue),
      SizedBox(width: 8),
      CustomText(
        "정보",
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ],
  ),
  message: "이것은 정보 다이얼로그입니다.",
  type: DialogType.single,
)
```

### 메시지에 여러 줄 텍스트

```dart
CustomDialog.show(
  context,
  title: "확인",
  message: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText("이것은 Widget을 사용한 다이얼로그입니다.", fontSize: 16),
      SizedBox(height: 8),
      CustomText(
        "제목과 메시지 모두 Widget으로 지정할 수 있습니다.",
        fontSize: 14,
        color: Colors.grey,
      ),
    ],
  ),
  type: DialogType.single,
)
```

### 복잡한 메시지 레이아웃

```dart
CustomDialog.show(
  context,
  title: "알림",
  message: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.warning, color: Colors.orange, size: 48),
      SizedBox(height: 16),
      CustomText("주의", fontSize: 20, fontWeight: FontWeight.bold),
      SizedBox(height: 8),
      CustomText("이 작업은 되돌릴 수 없습니다.", fontSize: 16),
    ],
  ),
  type: DialogType.dual,
  onConfirm: () {
    print("확인");
  },
)
```

---

## CustomSnackBar - Widget 사용

### 아이콘 + 텍스트

```dart
CustomSnackBar.show(
  context,
  message: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle, color: Colors.white),
      SizedBox(width: 8),
      Text(
        "성공적으로 완료되었습니다!",
        style: TextStyle(color: Colors.white),
      ),
    ],
  ),
  backgroundColor: Colors.green,
)
```

### 여러 줄 메시지

```dart
CustomSnackBar.show(
  context,
  message: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "제목",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 4),
      Text(
        "상세 메시지 내용",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    ],
  ),
  backgroundColor: Colors.blue,
  duration: Duration(seconds: 5),
)
```

### 커스텀 스타일

```dart
CustomSnackBar.showSuccess(
  context,
  message: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check_circle, color: Colors.white, size: 24),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "성공",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "작업이 완료되었습니다",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    ],
  ),
)
```

---

## CustomActionSheet - Widget 사용

### 아이콘 + 텍스트

```dart
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
```

### 커스텀 텍스트 스타일

```dart
CustomActionSheet.show(
  context,
  items: [
    ActionSheetItem(
      label: CustomText(
        "옵션 1",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      onTap: () {},
    ),
    ActionSheetItem(
      label: CustomText(
        "옵션 2",
        fontSize: 16,
        color: Colors.grey,
      ),
      onTap: () {},
    ),
  ],
)
```

### 복잡한 레이아웃

```dart
CustomActionSheet.show(
  context,
  title: "계정 관리",
  items: [
    ActionSheetItem(
      label: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.shade100,
            child: Icon(Icons.person, color: Colors.blue),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "프로필 수정",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "프로필 정보를 수정합니다",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {},
    ),
  ],
)
```

---

## CustomBottomNavBar - Widget 사용

### 텍스트만 (Widget)

```dart
CustomBottomNavBar(
  items: [
    BottomNavItem(
      icon: Icons.home,
      label: "홈",
      page: HomePage(),
    ),
    BottomNavItem(
      label: CustomText(
        "프로필",
        fontSize: 14,
        color: Colors.purple,
      ),
      page: ProfilePage(),
      selectedColor: Colors.purple,
      unselectedColor: Colors.grey.shade700,
    ),
  ],
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
)
```

### 복잡한 레이아웃

```dart
BottomNavItem(
  label: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.person, size: 20),
      SizedBox(height: 4),
      Text("프로필", style: TextStyle(fontSize: 10)),
    ],
  ),
  page: ProfilePage(),
)
```

---

## 조합 예제

### 복잡한 다이얼로그

```dart
CustomDialog.show(
  context,
  title: Row(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.info, color: Colors.blue),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "정보",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "시스템 알림",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    ],
  ),
  message: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("이것은 Widget을 사용한 다이얼로그입니다."),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text("상세 내용을 여기에 표시할 수 있습니다."),
      ),
    ],
  ),
  type: DialogType.single,
)
```

### 복잡한 버튼

```dart
CustomButton(
  btnText: Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_download, color: Colors.white),
        SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "다운로드",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "파일 다운로드",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
  backgroundColor: Colors.blue,
  minimumSize: Size(200, 60),
  onCallBack: () {
    print("다운로드 시작");
  },
)
```
