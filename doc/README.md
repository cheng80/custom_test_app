# 커스텀 위젯 및 유틸리티 개발 문서

이 폴더에는 커스텀 위젯 클래스들과 유틸리티 클래스들의 개발 문서와 예제 문서가 포함되어 있습니다.

## 문서 구조

### 위젯 개발 문서

- [기본 위젯](./01_Basic_Widgets.md) - Text, Button, Column, Row, Padding 등
- [레이아웃 위젯](./02_Layout_Widgets.md) - Card, Container, Image 등
- [입력 위젯](./03_Input_Widgets.md) - TextField 등
- [네비게이션 위젯](./04_Navigation_Widgets.md) - AppBar, BottomNavBar, TabBar 등
- [다이얼로그 및 알림](./05_Dialog_Notifications.md) - Dialog, SnackBar, ActionSheet
- [유틸리티](./06_Utilities.md) - CommonUtil, StorageUtil, CollectionUtil, TimerUtil, JsonUtil, NetworkUtil

### 예제 문서

- [기본 예제](./Examples/01_Basic_Examples.md)
- [고급 예제](./Examples/02_Advanced_Examples.md)
- [Widget 사용 예제](./Examples/03_Widget_Examples.md)

### 가이드 문서

- [오디오 가이드](./Guide/AUDIO_GUIDE.md) - Flutter 사운드 제어 방법
- [코루틴 가이드](./Guide/COROUTINE_GUIDE.md) - Unity 코루틴 vs Dart 비동기
- [네트워크 설계](./Guide/NETWORK_UTIL_DESIGN.md) - NetworkUtil 설계 문서

### 기타 문서

- [TODO](./TODO.md) - 구현 계획 및 진행 상황
- [유틸리티 추천](./UTILITY_RECOMMENDATIONS.md) - 유틸리티 클래스 추천 목록

## 주요 특징

모든 커스텀 위젯은 다음 원칙을 따릅니다:

- **기본값 제공**: 필수 요소만 입력하면 기본형으로 생성
- **유연한 커스터마이징**: 모든 속성을 선택적으로 오버라이드 가능
- **String/Widget 지원**: 텍스트 관련 속성은 String 또는 Widget 모두 지원
- **일관된 네이밍**: Custom 접두사 사용

## 빠른 시작

### Import 방법

```dart
// 단일 import (권장) - 모든 위젯과 유틸리티 사용
import 'package:custom_test_app/custom/custom.dart';

// 선택적 import - 위젯만 필요한 경우
import 'package:custom_test_app/custom/widgets.dart';

// 선택적 import - 핵심 유틸리티만 필요한 경우
import 'package:custom_test_app/custom/utils_core.dart';

// 선택적 import - 전체 유틸리티 (외부 패키지 의존성 필요)
import 'package:custom_test_app/custom/custom_full.dart';
```

### 사용 예시

```dart
// 기본 사용
CustomText("안녕하세요")
CustomButton(btnText: "확인", onCallBack: () {})

// Widget 사용
CustomButton(
  btnText: Row(children: [Icon(Icons.check), Text("확인")]),
  onCallBack: () {},
)

// 유틸리티 사용
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
CustomCollectionUtil.unique([1, 2, 2, 3]);
```
