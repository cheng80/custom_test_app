# 기본 예제

## CustomText 예제

### 기본 사용

```dart
CustomText("안녕하세요")
```

### 스타일 커스터마이징

```dart
CustomText(
  "커스텀 텍스트",
  fontSize: 24,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  textAlign: TextAlign.center,
)
```

---

## CustomButton 예제

### 기본 버튼

```dart
CustomButton(
  btnText: "확인",
  onCallBack: () {
    print("버튼 클릭");
  },
)
```

### 다양한 버튼 타입

```dart
// TextButton
CustomButton(
  btnText: "TextButton",
  buttonType: ButtonType.text,
  backgroundColor: Colors.blue,
  onCallBack: () {},
)

// ElevatedButton
CustomButton(
  btnText: "Elevated",
  buttonType: ButtonType.elevated,
  backgroundColor: Colors.green,
  onCallBack: () {},
)

// OutlinedButton
CustomButton(
  btnText: "Outlined",
  buttonType: ButtonType.outlined,
  backgroundColor: Colors.red,
  onCallBack: () {},
)
```

### 버튼 스타일 커스터마이징

```dart
CustomButton(
  btnText: "커스텀 버튼",
  backgroundColor: Colors.purple,
  minimumSize: Size(150, 50),
  borderRadius: 20,
  textFontSize: 18,
  textColor: Colors.white,
  onCallBack: () {},
)
```

---

## CustomColumn / CustomRow 예제

### CustomColumn

```dart
CustomColumn(
  spacing: 16,
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  padding: EdgeInsets.all(16),
  backgroundColor: Colors.grey.shade100,
  children: [
    CustomText("첫 번째 항목"),
    CustomText("두 번째 항목"),
    CustomText("세 번째 항목"),
  ],
)
```

### CustomRow

```dart
CustomRow(
  spacing: 12,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CustomText("왼쪽"),
    CustomText("가운데"),
    CustomText("오른쪽"),
  ],
)
```

---

## CustomPadding 예제

```dart
// 모든 방향
CustomPadding.all(16, child: CustomText("텍스트"))

// 수평 방향만
CustomPadding.horizontal(16, child: CustomText("텍스트"))

// 수직 방향만
CustomPadding.vertical(16, child: CustomText("텍스트"))

// 개별 방향
CustomPadding(
  child: CustomText("텍스트"),
  top: 20,
  bottom: 10,
  left: 16,
  right: 16,
)
```

---

## CustomCard / CustomContainer 예제

### CustomCard

```dart
CustomCard(
  padding: EdgeInsets.all(20),
  elevation: 4,
  borderRadius: 16,
  child: CustomColumn(
    spacing: 12,
    children: [
      CustomText("카드 제목", fontSize: 20, fontWeight: FontWeight.bold),
      CustomText("카드 내용", fontSize: 16),
    ],
  ),
)
```

### CustomContainer

```dart
CustomContainer(
  padding: EdgeInsets.all(16),
  backgroundColor: Colors.blue.shade50,
  borderRadius: 12,
  borderColor: Colors.blue,
  borderWidth: 2,
  shadowColor: Colors.blue.withOpacity(0.3),
  blurRadius: 8,
  child: CustomText("컨테이너 내용"),
)
```

---

## CustomImage 예제

```dart
// 기본 사용
CustomImage("images/logo.png")

// 크기 지정
CustomImage(
  "images/logo.png",
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)

// 에러 처리
CustomImage(
  "images/logo.png",
  errorWidget: Icon(Icons.broken_image, size: 50),
  loadingWidget: CircularProgressIndicator(),
)
```

---

## CustomIconButton 예제

```dart
// 기본 사용
CustomIconButton(
  icon: Icons.favorite,
  onPressed: () {
    print("좋아요");
  },
)

// 배경색과 둥근 모서리
CustomIconButton(
  icon: Icons.share,
  iconColor: Colors.blue,
  backgroundColor: Colors.blue.shade50,
  borderRadius: 8,
  onPressed: () {
    print("공유");
  },
)
```
