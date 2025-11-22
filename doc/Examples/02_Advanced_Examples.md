# 고급 예제

## CustomTextField 예제

### 기본 사용

```dart
TextEditingController _nameController = TextEditingController();

CustomTextField(
  controller: _nameController,
  labelText: "이름",
)
```

### Form과 함께 사용

```dart
final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();

Form(
  key: _formKey,
  child: CustomColumn(
    spacing: 16,
    children: [
      CustomTextField(
        controller: _nameController,
        labelText: "이름",
        required: true,
        requiredMessage: "이름을 입력해주세요",
      ),
      CustomTextField(
        controller: _emailController,
        labelText: "이메일",
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "이메일을 입력해주세요";
          }
          if (!value.contains('@')) {
            return "올바른 이메일 형식이 아닙니다";
          }
          return null;
        },
      ),
      CustomButton(
        btnText: "제출",
        onCallBack: () {
          if (_formKey.currentState!.validate()) {
            print("제출 성공");
          }
        },
      ),
    ],
  ),
)
```

### 키보드 자동 내리기

```dart
GestureDetector(
  onTap: () {
    FocusScope.of(context).unfocus();
  },
  child: Scaffold(
    body: CustomTextField(
      controller: _controller,
      labelText: "입력",
    ),
  ),
)
```

---

## CustomAppBar 예제

### 기본 사용

```dart
Scaffold(
  appBar: CustomAppBar(
    title: "홈",
    backgroundColor: Colors.blue,
  ),
  body: Container(),
)
```

### 액션 버튼 포함

```dart
Scaffold(
  appBar: CustomAppBar(
    title: "홈",
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
    ],
  ),
  body: Container(),
)
```

---

## CustomBottomNavBar 예제

### 기본 사용

```dart
int _currentIndex = 0;

CustomBottomNavBar(
  items: [
    BottomNavItem(
      icon: Icons.home,
      label: "홈",
      page: HomePage(),
    ),
    BottomNavItem(
      icon: Icons.search,
      label: "검색",
      page: SearchPage(),
    ),
    BottomNavItem(
      icon: Icons.favorite,
      page: FavoritePage(),
    ),
    BottomNavItem(
      label: "프로필",
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

### 각 페이지가 Scaffold인 경우

```dart
CustomBottomNavBar(
  items: [
    BottomNavItem(
      icon: Icons.home,
      label: "홈",
      page: Scaffold(
        appBar: CustomAppBar(title: "홈"),
        body: HomeContent(),
      ),
    ),
    BottomNavItem(
      icon: Icons.search,
      label: "검색",
      page: Scaffold(
        appBar: CustomAppBar(title: "검색"),
        body: SearchContent(),
      ),
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

---

## CustomTabBar 예제

### 기본 사용

```dart
CustomTabBar(
  tabs: ["동물", "과일", "꽃"],
  children: [
    AnimalTab(),
    FruitTab(),
    FlowerTab(),
  ],
)
```

### Scaffold와 함께 사용

```dart
Scaffold(
  appBar: CustomAppBar(title: "홈"),
  body: CustomTabBar(
    tabs: ["탭1", "탭2", "탭3"],
    tabColor: Colors.blue,
    children: [
      Tab1Content(),
      Tab2Content(),
      Tab3Content(),
    ],
  ),
)
```

---

## CustomDialog 예제

### 단일 버튼 다이얼로그

```dart
CustomDialog.show(
  context,
  title: "알림",
  message: "작업이 완료되었습니다.",
  type: DialogType.single,
  onConfirm: () {
    print("확인 버튼 클릭");
  },
)
```

### 이중 버튼 다이얼로그

```dart
CustomDialog.show(
  context,
  title: "확인",
  message: "정말로 삭제하시겠습니까?",
  type: DialogType.dual,
  confirmText: "삭제",
  cancelText: "취소",
  onConfirm: () {
    print("삭제 확인");
  },
  onCancel: () {
    print("취소");
  },
)
```

### 버튼 정렬

```dart
CustomDialog.show(
  context,
  title: "정렬 예시",
  message: "버튼이 왼쪽 정렬됩니다.",
  type: DialogType.dual,
  actionsAlignment: MainAxisAlignment.start,
)
```

---

## CustomSnackBar 예시

### 기본 사용

```dart
CustomSnackBar.show(
  context,
  message: "기본 메시지입니다.",
)
```

### 다양한 타입

```dart
// 성공
CustomSnackBar.showSuccess(
  context,
  message: "작업이 성공적으로 완료되었습니다!",
)

// 에러
CustomSnackBar.showError(
  context,
  message: "에러가 발생했습니다.",
)

// 경고
CustomSnackBar.showWarning(
  context,
  message: "주의가 필요한 상황입니다.",
)

// 정보
CustomSnackBar.showInfo(
  context,
  message: "이것은 정보 메시지입니다.",
)
```

### 액션 버튼 포함

```dart
CustomSnackBar.show(
  context,
  message: "메시지를 삭제하시겠습니까?",
  actionLabel: "실행",
  onAction: () {
    print("삭제 실행");
  },
)
```

---

## CustomActionSheet 예제

### 기본 사용

```dart
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
```

### 위험 작업 포함

```dart
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
```

### 간단한 사용

```dart
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

---

## CustomListView 예제

### 기본 사용

```dart
CustomListView(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return CustomCard(
      child: CustomText(items[index]),
    );
  },
)
```

### 간격 및 구분선

```dart
CustomListView(
  itemCount: items.length,
  itemSpacing: 8,
  separator: Divider(height: 1),
  itemBuilder: (context, index) {
    return ListTile(
      title: CustomText(items[index]),
    );
  },
)
```

### 로딩 및 빈 상태 처리

```dart
CustomListView(
  itemCount: items.length,
  isLoading: isLoading,
  loadingWidget: CircularProgressIndicator(),
  emptyWidget: CustomText("항목이 없습니다"),
  itemBuilder: (context, index) {
    return CustomCard(
      child: CustomText(items[index]),
    );
  },
)
```
