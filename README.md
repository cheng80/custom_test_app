# Custom Test App

Flutter 커스텀 위젯 및 유틸리티 라이브러리 프로젝트입니다.

## 📋 프로젝트 개요

이 프로젝트는 Flutter 개발 시 자주 사용하는 UI 위젯과 유틸리티 함수들을 커스텀 클래스로 만들어 재사용성을 높이고, 개발 효율을 향상시키기 위한 목적으로 제작되었습니다.

### 주요 특징

- **기본값 제공**: 필수 요소만 입력하면 기본형으로 생성
- **유연한 커스터마이징**: 모든 속성을 선택적으로 오버라이드 가능
- **String/Widget 지원**: 텍스트 관련 속성은 String 또는 Widget 모두 지원
- **일관된 네이밍**: Custom 접두사 사용
- **외부 패키지 최소화**: 가능한 한 순수 Dart로 구현

## 🏗️ 프로젝트 구조

```
lib/
└── custom/                        # 커스텀 위젯 및 유틸리티 (일관된 구조)
    ├── custom.dart                # 편의용: widgets + utils 모두 export
    ├── widgets.dart               # 위젯만 export
    ├── utils_core.dart            # 핵심 유틸리티만 export (의존성 없음)
    ├── custom_full.dart           # 전체 기능 export (의존성 필요)
    ├── custom_text.dart           # 텍스트 위젯
    ├── custom_button.dart         # 버튼 위젯 (TextButton, ElevatedButton, OutlinedButton)
    ├── custom_column.dart         # Column 위젯
    ├── custom_row.dart            # Row 위젯
    ├── custom_padding.dart        # Padding 위젯
    ├── custom_image.dart          # Image.asset 위젯
    ├── custom_icon_button.dart    # IconButton 위젯
    ├── custom_card.dart           # Card 위젯
    ├── custom_container.dart      # Container 위젯
    ├── custom_text_field.dart     # TextField 위젯
    ├── custom_switch.dart          # Switch 위젯
    ├── custom_checkbox.dart       # Checkbox 위젯
    ├── custom_radio.dart           # Radio 위젯
    ├── custom_slider.dart          # Slider 위젯
    ├── custom_cupertino_date_picker.dart  # CupertinoDatePicker 위젯
    ├── custom_date_picker.dart     # DatePicker 헬퍼
    ├── custom_picker_view.dart     # PickerView 위젯
    ├── custom_grid_view.dart       # GridView.builder 위젯
    ├── custom_dropdown_button.dart # DropdownButton 위젯
    ├── custom_app_bar.dart        # AppBar 위젯 (String/Widget 지원)
    ├── custom_dialog.dart         # AlertDialog 헬퍼
    ├── custom_list_view.dart      # ListView.builder 위젯
    ├── custom_tab_bar.dart        # TabBar 위젯
    ├── custom_bottom_nav_bar.dart # BottomNavigationBar 위젯
    ├── custom_snack_bar.dart      # SnackBar 헬퍼
    ├── custom_action_sheet.dart   # ActionSheet 헬퍼
    ├── custom_common_util.dart    # 공용 유틸리티 (날짜, 문자열, 검증, 포맷팅, 숫자)
    └── util/                      # 추가 유틸리티 (외부 의존성 없음)
        ├── collection/            # 컬렉션 유틸리티
        │   ├── custom_collection_util.dart
        │   ├── example.dart
        │   └── README.md
        ├── json/                  # JSON 변환 유틸리티
        │   ├── custom_json_util.dart
        │   ├── example.dart
        │   └── README.md
        └── timer/                 # 타이머 유틸리티
            ├── custom_timer_util.dart
            ├── example.dart
            └── README.md
    └── external_util/            # 외부 의존성이 필요한 유틸리티
        ├── storage/               # 로컬 스토리지 유틸리티 (shared_preferences 필요)
        │   ├── custom_storage_util.dart
        │   ├── example.dart
        │   └── README.md
        └── network/               # HTTP 통신 유틸리티 (http 패키지 필요)
            ├── custom_network_util.dart
            ├── network_response.dart
            ├── example.dart
            └── README.md
├── pages/                         # 예제 페이지
│   ├── text_field_page.dart      # TextField 예제
│   ├── list_view_page.dart       # ListView 예제
│   ├── dialog_page.dart          # Dialog 예제
│   ├── tab_bar_page.dart         # TabBar & BottomNavBar 예제
│   ├── snackbar_action_sheet_page.dart  # SnackBar & ActionSheet 예제
│   ├── picker_grid_page.dart     # Picker & Grid 예제
│   ├── storage_page.dart         # StorageUtil 예제
│   ├── network_page.dart         # NetworkUtil 예제
│   └── util_page.dart            # 유틸리티 예제
├── home.dart                     # 메인 홈 화면 (모든 위젯 예제)
└── main.dart                     # 앱 진입점

lib_doc/                           # 개발 문서
├── README.md                      # 문서 개요
├── 01_Basic_Widgets.md            # 기본 위젯 문서
├── 02_Layout_Widgets.md           # 레이아웃 위젯 문서
├── 03_Input_Widgets.md            # 입력 위젯 문서
├── 04_Navigation_Widgets.md       # 네비게이션 위젯 문서
├── 05_Dialog_Notifications.md     # 다이얼로그 및 알림 문서
├── 06_Utilities.md                # 유틸리티 문서
├── TODO.md                        # 향후 구현 계획
├── UTILITY_RECOMMENDATIONS.md     # 유틸리티 추천 목록
└── Examples/                      # 예제 문서
    ├── 01_Basic_Examples.md
    ├── 02_Advanced_Examples.md
    └── 03_Widget_Examples.md
```

## 🎨 커스텀 위젯 목록

### 기본 위젯

- **CustomText**: 기본 스타일이 적용된 텍스트 위젯
- **CustomButton**: TextButton, ElevatedButton, OutlinedButton 지원
- **CustomColumn**: 기본 spacing과 정렬이 적용된 Column
- **CustomRow**: 기본 spacing과 정렬이 적용된 Row
- **CustomPadding**: 편의 생성자 제공 (all, horizontal, vertical)

### 레이아웃 위젯

- **CustomCard**: Material Design Card 위젯
- **CustomContainer**: 유연한 스타일링이 가능한 Container
- **CustomImage**: 에러 처리와 로딩 위젯 지원
- **CustomIconButton**: 배경색과 둥근 모서리 지원

### 입력 위젯

- **CustomTextField**: 기본 검증 및 키보드 관리 기능 포함
- **CustomSwitch**: 스위치(켜짐/꺼짐) 토글 위젯
- **CustomCheckbox**: 체크박스 위젯
- **CustomRadio**: 라디오 버튼 위젯 (Flutter 3.24+ Radio.adaptive 지원)
- **CustomSlider**: 슬라이더 위젯 (연속적인 값 선택)
- **CustomDropdownButton**: 드롭다운 메뉴 위젯 (String/Widget 지원)

### 네비게이션 위젯

- **CustomAppBar**: 기본 스타일이 적용된 AppBar
- **CustomBottomNavBar**: 페이지 전환을 자동으로 처리하는 BottomNavigationBar
- **CustomTabBar**: TabBar와 TabBarView를 통합한 위젯

### 다이얼로그 및 알림

- **CustomDialog**: AlertDialog 헬퍼 클래스
- **CustomSnackBar**: SnackBar 헬퍼 클래스 (success, error, warning, info)
- **CustomActionSheet**: ActionSheet 헬퍼 클래스

### 리스트 및 그리드

- **CustomListView**: ListView.builder를 간편하게 사용
- **CustomGridView**: GridView.builder를 간편하게 사용

### 날짜/시간 선택

- **CustomDatePicker**: Material Design 날짜 선택 다이얼로그 헬퍼
- **CustomCupertinoDatePicker**: iOS 스타일 날짜 선택기 위젯

### 선택 위젯

- **CustomPickerView**: 리스트에서 항목 선택 위젯 (단일/다중 선택 지원)

## 🛠️ 유틸리티 클래스

### CustomCommonUtil

공용 유틸리티 클래스로 다음 기능을 제공합니다:

- **위젯 관련**: String/Widget 변환
- **날짜/시간**: 포맷팅, 비교, 계산, 상대 시간 표시
- **문자열**: 검증, 변환, 포맷팅, 자르기
- **검증**: 이메일, 전화번호, URL, 비밀번호 강도 등
- **포맷팅**: 파일 크기, 시간, 거리, 가격, 퍼센트
- **숫자**: 포맷팅, 안전한 변환, 검증, 통화/퍼센트

### CustomStorageUtil

로컬 스토리지 유틸리티 (SharedPreferences 래핑):

- 기본 타입 저장/불러오기 (String, int, bool, double, StringList)
- 객체 저장/불러오기 (JSON 직렬화/역직렬화)
- 리스트 저장/불러오기
- 키 관리 (삭제, 전체 삭제, 존재 여부 확인)

**의존성**: `shared_preferences: ^2.2.2`

### CustomCollectionUtil

컬렉션(리스트) 처리 유틸리티:

- null-safe 체크
- 중복 제거
- 그룹화
- 평탄화
- 필터링/매핑
- 청크로 나누기
- 정렬/섞기
- 딥카피 (리스트, 맵, 중첩 구조)
- **Record 관련** (Dart 3.0+): 필드 추출, 맵 변환, 필터링/매핑, 정렬, 최대값/최소값, 합계/평균

**의존성**: 없음 (순수 Dart)

### CustomJsonUtil

저장소와 무관한 순수 JSON 변환 유틸리티:

- JSON 디코딩/인코딩
- JSON 검증
- 객체 ↔ JSON 변환
- JSON 포맷팅 (들여쓰기, 압축)
- JSON 병합/수정 (경로 기반 값 가져오기/설정/삭제)
- 안전한 JSON 변환 (에러 처리)

**의존성**: `dart:convert` (기본 제공)

**참고**: StorageUtil의 JSON 기능은 저장소 연동용이며, JsonUtil은 저장소와 무관한 순수 JSON 변환 유틸리티입니다.

### CustomTimerUtil

타이머 관리 유틸리티 (Unity 코루틴과 유사한 기능):

- 기본 타이머 (지연 실행, 반복 실행)
- 코루틴 유사 기능 (waitForSeconds, waitUntil, waitWhile, waitForNextFrame)
- 고급 타이머 기능 (타임아웃, 재시도, 디바운싱, 스로틀링)
- ID 기반 타이머 관리 (생성, 취소, 일시정지, 재개)
- 여러 타이머 독립 실행 및 일괄 관리

**의존성**: 없음 (순수 Dart)

### CustomNetworkUtil

HTTP 통신 유틸리티:

- HTTP 메서드 지원 (GET, POST, PUT, DELETE, PATCH)
- JsonUtil과 연동하여 요청/응답 JSON 변환
- 헤더 관리 (기본 헤더, 인증 토큰)
- 에러 처리 (네트워크 에러, HTTP 에러, JSON 파싱 에러)
- 타임아웃 설정
- 쿼리 파라미터 자동 변환

**의존성**: `http: ^1.1.0`

## 📦 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2 # StorageUtil에서 사용
  http: ^1.1.0 # NetworkUtil에서 사용
```

**참고**:

- `flutter_localizations`는 DatePicker 및 CupertinoDatePicker의 다국어 지원을 위해 필요합니다.
- `shared_preferences`는 StorageUtil 사용 시 필요합니다.
- `http`는 NetworkUtil 사용 시 필요합니다.

## 🚀 시작하기

### 1. 프로젝트 클론

```bash
git clone <repository-url>
cd custom_test_app
```

### 2. 의존성 설치

```bash
flutter pub get
```

### 3. 앱 실행

```bash
flutter run
```

### 4. StorageUtil 사용 시 초기화

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomStorageUtil.init();  // 앱 시작 시 한 번만 호출
  runApp(MyApp());
}
```

### 5. 다국어 지원 설정

DatePicker 및 CupertinoDatePicker의 언어는 MaterialApp의 `localizationsDelegates`와 `supportedLocales` 설정에 따라 결정됩니다.

**pubspec.yaml 설정:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

**main.dart 설정 예시:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 다국어 지원
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 영어
        const Locale('ko', 'KR'), // 한국어
        const Locale('ja', 'JP'), // 일본어
      ],
      // ... 기타 설정
    );
  }
}
```

**주의사항:**

- DatePicker의 언어는 디바이스의 언어 설정에 따라 자동으로 변경됩니다.
- 특정 언어를 강제하려면 `CustomDatePicker.show()`의 `locale` 파라미터를 사용하세요.
- `flutter_localizations`는 Flutter SDK에 포함되어 있어 `pubspec.yaml`에 추가만 하면 됩니다.

## 📦 Import 방법

### 단일 Import (권장)

GetX처럼 하나의 import로 모든 위젯과 유틸리티를 사용할 수 있습니다:

```dart
// 모든 위젯과 유틸리티 사용
import 'package:custom_test_app/custom/custom.dart';

// 사용 예시
CustomText("안녕하세요")
CustomButton(btnText: "확인", onCallBack: () {})
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
```

### 선택적 Import

필요에 따라 위젯만 또는 유틸리티만 import할 수 있습니다:

```dart
// 위젯만 필요한 경우
import 'package:custom_test_app/custom/widgets.dart';

// 핵심 유틸리티만 필요한 경우
import 'package:custom_test_app/custom/utils_core.dart';

// 전체 유틸리티 (외부 패키지 의존성 필요)
import 'package:custom_test_app/custom/custom_full.dart';

// 둘 다 필요한 경우
import 'package:custom_test_app/custom/custom.dart';
// 또는
import 'package:custom_test_app/custom/widgets.dart';
import 'package:custom_test_app/custom/utils_core.dart';
```

### 기존 방식 (개별 Import)

기존처럼 개별 파일을 직접 import하는 것도 가능합니다:

```dart
import 'package:custom_test_app/custom/custom_text.dart';
import 'package:custom_test_app/custom/custom_button.dart';
```

**참고**: 단일 import 방식을 사용하면 코드가 더 간결하고 유지보수가 쉬워집니다. 또한 `lib/custom/` 폴더 구조로 향후 라이브러리로 분리할 때도 용이합니다.

## 💡 사용 예시

### 기본 위젯 사용

```dart
// 텍스트
CustomText("안녕하세요")

// 버튼
CustomButton(
  btnText: "확인",
  onCallBack: () {
    print("버튼 클릭");
  },
)

// Column
CustomColumn(
  spacing: 16,
  children: [
    CustomText("첫 번째"),
    CustomText("두 번째"),
  ],
)
```

### Widget 사용 (String 대신)

```dart
CustomButton(
  btnText: Row(
    children: [
      Icon(Icons.check),
      Text("확인"),
    ],
  ),
  onCallBack: () {},
)
```

### 유틸리티 사용

```dart
// 날짜 포맷팅
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');

// 문자열 검증
CustomCommonUtil.isEmail('test@example.com');

// 숫자 포맷팅
CustomCommonUtil.formatNumber(1234567); // '1,234,567'

// 리스트 중복 제거
CustomCollectionUtil.unique([1, 2, 2, 3]); // [1, 2, 3]

// Record 처리
final records = [(id: 1, name: '홍길동'), (id: 2, name: '김철수')];
final names = CustomCollectionUtil.extractField(records, (r) => r.name);

// JSON 변환
final jsonString = CustomJsonUtil.encode({'name': '홍길동', 'age': 25});
final user = CustomJsonUtil.fromJson<User>(jsonString, (json) => User.fromJson(json));

// 타이머 (Unity 코루틴 유사)
await CustomTimerUtil.waitForSeconds(2.0);
final debounced = CustomTimerUtil.debounce(() => performSearch(), Duration(milliseconds: 500));

// HTTP 통신
final response = await CustomNetworkUtil.get<User>(
  '/api/users/1',
  fromJson: (json) => User.fromJson(json),
);

// 날짜 선택
final selectedDate = await CustomDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
);

// iOS 스타일 날짜 선택기
CustomCupertinoDatePicker(
  mode: CupertinoDatePickerMode.dateAndTime,
  onDateTimeChanged: (dateTime) {},
)

// 드롭다운 메뉴
CustomDropdownButton<String>(
  value: selectedValue,
  items: ['옵션1', '옵션2', '옵션3'],
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)

// 선택 위젯
CustomPickerView<String>(
  items: ['옵션1', '옵션2', '옵션3'],
  selectedItem: selectedValue,
  onItemSelected: (item) {},
)

// 그리드 뷰
CustomGridView(
  itemCount: 20,
  crossAxisCount: 2,
  itemBuilder: (context, index) => Card(...),
)
```

## 📚 문서

자세한 사용법과 API 문서는 `lib_doc/` 폴더를 참고하세요:

- [기본 위젯 문서](lib_doc/01_Basic_Widgets.md)
- [레이아웃 위젯 문서](lib_doc/02_Layout_Widgets.md)
- [입력 위젯 문서](lib_doc/03_Input_Widgets.md)
- [네비게이션 위젯 문서](lib_doc/04_Navigation_Widgets.md)
- [다이얼로그 및 알림 문서](lib_doc/05_Dialog_Notifications.md)
- [유틸리티 문서](lib_doc/06_Utilities.md)
- [예제 문서](lib_doc/Examples/)
- [가이드 문서](lib_doc/Guide/) - 오디오, 코루틴, 네트워크 설계 가이드

## 🎯 주요 원칙

1. **기본값 제공**: 필수 요소만 입력하면 기본형으로 생성
2. **유연한 커스터마이징**: 모든 속성을 선택적으로 오버라이드 가능
3. **타입 안전성**: null-safety를 고려한 안전한 구현
4. **외부 패키지 최소화**: 가능한 한 순수 Dart로 구현
5. **일관된 네이밍**: Custom 접두사 사용

## 🔄 향후 계획

향후 구현 계획은 [TODO.md](lib_doc/TODO.md)를 참고하세요.

주요 예정 항목:

- AudioUtil (오디오 재생 관리)
- LogUtil (로깅 유틸리티)
- ColorUtil (색상 처리)
- FileUtil (파일 처리)
- DeviceUtil (디바이스 정보)
- CryptoUtil (암호화/해시)

**완료된 항목** ✅:

- DebounceUtil / ThrottleUtil (TimerUtil에 통합)
- JsonUtil (순수 JSON 변환)
- NetworkUtil (HTTP 통신)
- CustomCupertinoDatePicker (iOS 스타일 날짜 선택기)
- CustomDatePicker (Material Design 날짜 선택)
- CustomPickerView (리스트 선택 위젯)
- CustomGridView (그리드 레이아웃)
- CustomDropdownButton (드롭다운 메뉴)
- 다국어 지원 설정 (DatePicker, CupertinoDatePicker)

## 📝 라이선스

이 프로젝트는 개인/내부 사용 목적으로 제작되었습니다.

## 👤 작성자

Custom Test App 개발팀

---

**참고**: 이 프로젝트는 Flutter 개발 효율 향상을 위한 커스텀 위젯 및 유틸리티 라이브러리입니다. 프로젝트 특성에 맞게 필요한 위젯과 유틸리티만 선택적으로 사용하는 것을 권장합니다.
