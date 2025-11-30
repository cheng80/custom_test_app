# 레이아웃 위젯 클래스

## CustomCard

Material Design의 Card 위젯을 기반으로 한 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomCard(
  child: CustomText("카드 내용"),
)
```

### 주요 속성

| 속성           | 타입           | 기본값               | 설명                         |
| -------------- | -------------- | -------------------- | ---------------------------- |
| `child`        | `Widget`       | 필수                 | 카드 내부에 표시할 자식 위젯 |
| `color`        | `Color?`       | `null`               | 카드 배경색                  |
| `elevation`    | `double?`      | `2`                  | 카드 elevation (그림자 효과) |
| `borderRadius` | `double?`      | `12`                 | 카드 모서리 둥글기           |
| `padding`      | `EdgeInsets?`  | `EdgeInsets.all(16)` | 카드 내부 패딩               |
| `margin`       | `EdgeInsets?`  | `null`               | 카드 마진                    |
| `width`        | `double?`      | `null`               | 카드 너비                    |
| `height`       | `double?`      | `null`               | 카드 높이                    |
| `shape`        | `ShapeBorder?` | `null`               | 카드 모양                    |

### 사용 예시

```dart
// 기본 사용
CustomCard(
  child: CustomText("카드 내용"),
)

// 스타일 커스터마이징
CustomCard(
  color: Colors.white,
  elevation: 4,
  borderRadius: 16,
  padding: EdgeInsets.all(20),
  child: CustomText("커스텀 카드"),
)

// 크기 지정
CustomCard(
  width: 200,
  height: 150,
  child: CustomText("고정 크기 카드"),
)
```

---

## CustomContainer

Container를 기반으로 한 커스텀 위젯입니다. CustomCard보다 더 유연한 커스터마이징이 가능합니다.

### 기본 사용법

```dart
CustomContainer(
  child: CustomText("컨테이너 내용"),
)
```

### 주요 속성

| 속성              | 타입                 | 기본값         | 설명                             |
| ----------------- | -------------------- | -------------- | -------------------------------- |
| `child`           | `Widget`             | 필수           | 컨테이너 내부에 표시할 자식 위젯 |
| `backgroundColor` | `Color?`             | `null`         | 배경색                           |
| `borderRadius`    | `double?`            | `null`         | 모서리 둥글기                    |
| `padding`         | `EdgeInsets?`        | `null`         | 내부 패딩                        |
| `margin`          | `EdgeInsets?`        | `null`         | 마진                             |
| `borderColor`     | `Color?`             | `null`         | 테두리 색상                      |
| `borderWidth`     | `double?`            | `1.0`          | 테두리 두께                      |
| `shadowColor`     | `Color?`             | `null`         | 그림자 색상                      |
| `blurRadius`      | `double?`            | `8.0`          | 그림자 블러 반경                 |
| `spreadRadius`    | `double?`            | `1.0`          | 그림자 확산 반경                 |
| `shadowOffset`    | `Offset?`            | `Offset(0, 2)` | 그림자 오프셋                    |
| `width`           | `double?`            | `null`         | 너비                             |
| `height`          | `double?`            | `null`         | 높이                             |
| `alignment`       | `AlignmentGeometry?` | `null`         | 정렬 방식                        |
| `constraints`     | `BoxConstraints?`    | `null`         | 제약 조건                        |

### 사용 예시

```dart
// 기본 사용
CustomContainer(
  child: CustomText("컨테이너 내용"),
)

// 배경색과 테두리
CustomContainer(
  backgroundColor: Colors.blue.shade50,
  borderRadius: 12,
  borderColor: Colors.blue,
  borderWidth: 2,
  padding: EdgeInsets.all(16),
  child: CustomText("스타일 적용 컨테이너"),
)

// 그림자 효과
CustomContainer(
  backgroundColor: Colors.white,
  borderRadius: 12,
  shadowColor: Colors.grey.withOpacity(0.3),
  blurRadius: 10,
  spreadRadius: 2,
  shadowOffset: Offset(0, 4),
  padding: EdgeInsets.all(16),
  child: CustomText("그림자 효과 컨테이너"),
)
```

### CustomCard vs CustomContainer

| 특징            | CustomCard           | CustomContainer           |
| --------------- | -------------------- | ------------------------- |
| 기반 위젯       | Card                 | Container                 |
| Material Design | 자동 적용            | 수동 설정                 |
| elevation       | 지원                 | 미지원 (boxShadow 사용)   |
| 커스터마이징    | 제한적               | 매우 유연함               |
| 테두리          | shape로 제어         | borderColor/borderWidth   |
| 사용 시기       | Material 스타일 카드 | 세부 커스터마이징 필요 시 |

---

## CustomImage

이미지를 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomImage("images/logo.png")
```

### 주요 속성

| 속성             | 타입                 | 기본값                 | 설명                            |
| ---------------- | -------------------- | ---------------------- | ------------------------------- |
| `path`           | `String`             | 필수                   | 이미지 경로                     |
| `width`          | `double?`            | `null`                 | 이미지 너비                     |
| `height`         | `double?`            | `null`                 | 이미지 높이                     |
| `fit`            | `BoxFit?`            | `BoxFit.contain`       | 이미지 크기 조정 방식           |
| `errorWidget`    | `Widget?`            | 기본 위젯              | 이미지 로드 실패 시 표시할 위젯 |
| `loadingWidget`  | `Widget?`            | `null`                 | 이미지 로드 중 표시할 위젯      |
| `color`          | `Color?`             | `null`                 | 이미지 색상 필터                |
| `colorBlendMode` | `BlendMode?`         | `null`                 | 이미지 색상 블렌드 모드         |
| `repeat`         | `ImageRepeat?`       | `ImageRepeat.noRepeat` | 이미지 반복 방식                |
| `alignment`      | `AlignmentGeometry?` | `Alignment.center`     | 이미지 정렬 방식                |

### 사용 예시

```dart
// 기본 사용
CustomImage("images/logo.png")

// 크기 지정
CustomImage(
  "images/logo.png",
  width: 100,
  height: 100,
)

// fit 지정
CustomImage(
  "images/logo.png",
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)

// 에러 처리
CustomImage(
  "images/logo.png",
  errorWidget: Icon(Icons.broken_image, size: 50),
)
```

---

## CustomIconButton

아이콘 버튼을 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomIconButton(
  icon: Icons.favorite,
  onPressed: () {
    print("좋아요");
  },
)
```

### 주요 속성

| 속성              | 타입           | 기본값         | 설명                            |
| ----------------- | -------------- | -------------- | ------------------------------- |
| `icon`            | `IconData`     | 필수           | 표시할 아이콘                   |
| `onPressed`       | `VoidCallback` | 필수           | 아이콘 버튼 클릭 시 실행될 콜백 |
| `iconSize`        | `double?`      | `24`           | 아이콘 크기                     |
| `iconColor`       | `Color?`       | `Colors.black` | 아이콘 색상                     |
| `backgroundColor` | `Color?`       | `null`         | 아이콘 버튼 배경색              |
| `size`            | `double?`      | `48`           | 아이콘 버튼 크기                |
| `borderRadius`    | `double?`      | `null`         | 아이콘 버튼 모서리 둥글기       |
| `tooltip`         | `String?`      | `null`         | 툴팁 메시지                     |
| `enabled`         | `bool`         | `true`         | 아이콘 버튼 활성화 여부         |

### 사용 예시

```dart
// 기본 사용
CustomIconButton(
  icon: Icons.favorite,
  onPressed: () {},
)

// 배경색과 둥근 모서리
CustomIconButton(
  icon: Icons.favorite,
  iconColor: Colors.red,
  backgroundColor: Colors.red.shade50,
  borderRadius: 8,
  onPressed: () {},
)

// 크기 조정
CustomIconButton(
  icon: Icons.share,
  iconSize: 32,
  size: 64,
  onPressed: () {},
)
```
