# 커스텀 라이브러리 사용 가이드

## 다른 프로젝트에서 사용하기

### 1. 폴더 복사

`lib/custom/` 폴더 전체를 다른 프로젝트의 `lib/` 폴더로 복사합니다.

```bash
cp -r lib/custom /path/to/other/project/lib/
```

### 2. Import 방법

#### 방법 1: 기본 기능 사용 (외부 패키지 의존성 없음) ⭐ 권장

```dart
import 'package:your_project/custom/custom.dart';

// 위젯 사용
CustomText("안녕하세요")
CustomButton(btnText: "확인", onCallBack: () {})

// 핵심 유틸리티 사용 (외부 패키지 의존성 없음)
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
CustomCollectionUtil.unique([1, 2, 2, 3]);
CustomJsonUtil.encode({'key': 'value'});
CustomTimerUtil.waitForSeconds(2.0);
```

**주의**: `custom.dart`는 `utils_core.dart`만 export하지만, **storage/network 폴더가 존재하면 pubspec.yaml에 의존성을 추가해야 합니다.**

Dart는 export되지 않은 파일이라도 프로젝트에 존재하면 컴파일 시 의존성을 체크합니다. export되지 않아도 파일이 존재하면 의존성이 필요합니다.

**의존성 불필요한 경우**: storage/network 폴더를 삭제하거나, pubspec.yaml에 의존성을 추가해야 합니다.

#### 방법 1-1: 모든 기능 사용 (외부 패키지 의존성 필요)

```dart
import 'package:your_project/custom/custom_full.dart';

// 위젯 사용
CustomText("안녕하세요")
CustomButton(btnText: "확인", onCallBack: () {})

// 모든 유틸리티 사용 (StorageUtil, NetworkUtil 포함)
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
CustomStorageUtil.setString('key', 'value');  // shared_preferences 필요
CustomNetworkUtil.get('/api/users');  // http 패키지 필요
```

**필수 의존성 (pubspec.yaml):**

```yaml
dependencies:
  shared_preferences: ^2.2.2
  http: ^1.1.0
```

#### 방법 2: 위젯 + 핵심 유틸리티 (외부 패키지 의존성 없음) ⭐ 권장

```dart
import 'package:your_project/custom/custom.dart';

// 위젯 + 핵심 유틸리티 모두 사용 (외부 패키지 의존성 없음)
CustomText("안녕하세요")
CustomButton(btnText: "확인", onCallBack: () {})
CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
CustomCollectionUtil.unique([1, 2, 2, 3]);
```

**의존성 불필요** - 순수 Dart만 사용

또는 개별 import:

```dart
import 'package:your_project/custom/widgets.dart';
import 'package:your_project/custom/utils_core.dart';
```

#### 방법 3: 필요한 유틸리티만 선택적으로 사용

```dart
// 위젯만
import 'package:your_project/custom/widgets.dart';

// 핵심 유틸리티만
import 'package:your_project/custom/utils_core.dart';

// 스토리지 유틸리티만 (shared_preferences 필요)
import 'package:your_project/custom/util/storage/custom_storage_util.dart';

// 네트워크 유틸리티만 (http 패키지 필요)
import 'package:your_project/custom/util/network/custom_network_util.dart';
```

### 3. 의존성 관리 (중요!)

**질문: storage/network 폴더가 존재하면 의존성을 추가해야 하나요?**

**답변: 네!** export되지 않아도 파일이 존재하면 Dart 컴파일러가 의존성을 체크합니다.

#### 현재 구조

- `custom.dart` → `utils_core.dart`만 export (storage/network export 안 함)
- `utils_core.dart` → storage/network export 안 함
- **하지만** storage/network 폴더가 존재하면 Dart 컴파일러가 의존성을 체크합니다

**중요한 사실**:

- Dart는 export되지 않은 파일이라도 **프로젝트에 존재하면 컴파일 시 의존성을 체크**합니다
- export되지 않아도 파일이 존재하면 pubspec.yaml에 의존성을 추가해야 합니다
- 단지 export되지 않아서 **실제 코드는 컴파일되지 않아 용량만 절약**될 뿐입니다

**해결 방법**:

1. storage/network를 사용하지 않는 경우: 폴더를 삭제
2. storage/network를 사용하는 경우: pubspec.yaml에 의존성 추가

**핵심 정리**:

- 파일이 존재하면 export 여부와 관계없이 의존성이 필요합니다
- export되지 않으면 실제 코드는 컴파일되지 않아 **용량만 절약**됩니다
- 진짜로 의존성이 필요 없는 경우: 폴더를 삭제하세요

#### 의존성이 필요한 경우

다음 파일들을 import하면 의존성이 필요합니다:

```dart
// ❌ 이 경우 의존성 필요
import 'package:your_project/custom/custom_full.dart';  // storage/network 포함
import 'package:your_project/custom/util/storage/custom_storage_util.dart';  // shared_preferences 필요
import 'package:your_project/custom/util/network/custom_network_util.dart';  // http 패키지 필요

// ⚠️ 주의: custom.dart를 사용해도 storage/network 폴더가 존재하면 의존성 필요
import 'package:your_project/custom/custom.dart';  // utils_core만 export (하지만 폴더 존재 시 의존성 필요)
import 'package:your_project/custom/widgets.dart';  // 위젯만 (의존성 불필요)
import 'package:your_project/custom/utils_core.dart';  // 핵심 유틸리티만 (의존성 불필요)

// ✅ 진짜 의존성 불필요: storage/network 폴더를 삭제한 경우
```

### 4. 사용하지 않는 유틸리티 제거 (필수) ⚠️

**중요**: storage/network 폴더가 존재하면 pubspec.yaml에 의존성을 추가해야 합니다.
export되지 않아도 파일이 존재하면 컴파일 시 의존성 체크를 하기 때문입니다.

#### 옵션 A: 폴더 삭제 (권장) ⭐

storage/network를 전혀 사용하지 않는 경우 폴더를 삭제:

```bash
# 스토리지 유틸리티 사용하지 않는 경우
rm -rf lib/custom/util/storage

# 네트워크 유틸리티 사용하지 않는 경우
rm -rf lib/custom/util/network
```

**장점**: 진짜로 의존성이 필요 없어집니다.

**주의**: 폴더를 삭제한 경우 `custom_full.dart`에서 해당 export도 제거해야 합니다.

#### 옵션 B: pubspec.yaml에 의존성 추가

폴더를 유지하면서 사용하지 않는 경우:

```yaml
dependencies:
  shared_preferences: ^2.2.2 # storage 폴더가 존재하면 필요
  http: ^1.1.0 # network 폴더가 존재하면 필요
```

**단점**: 사용하지 않아도 의존성을 추가해야 합니다.

**참고**: export되지 않으면 실제 코드는 컴파일되지 않아 용량만 절약됩니다.

#### 옵션 C: 선택적 import (폴더 유지 + 의존성 추가)

폴더를 유지하면서 필요한 것만 import:

```dart
// 스토리지 유틸리티만 필요한 경우
import 'package:your_project/custom/util/storage/custom_storage_util.dart';

// 네트워크 유틸리티만 필요한 경우
import 'package:your_project/custom/util/network/custom_network_util.dart';
```

**주의**: 폴더가 존재하면 pubspec.yaml에 의존성을 추가해야 합니다.

### 5. 의존성 관리

#### 기본 버전 사용 (권장) ⭐

```yaml
dependencies:
  flutter:
    sdk: flutter
  # 외부 패키지 의존성 없음
```

`custom.dart`를 사용하면 외부 패키지 의존성이 필요 없습니다.

#### 전체 기능 사용하는 경우

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2 # StorageUtil용
  http: ^1.1.0 # NetworkUtil용
```

`custom_full.dart`를 사용하는 경우에만 필요합니다.

#### 선택적 사용

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2 # StorageUtil만 사용하는 경우
  # http 패키지는 필요 없음
```

`custom.dart` + 스토리지 유틸리티를 사용하는 경우

## 권장 사용 방법

1. **기본적으로 `custom.dart` 사용** ⭐ - 외부 패키지 의존성 없이 시작
2. **필요할 때만 추가** - StorageUtil이나 NetworkUtil이 필요할 때만 직접 import
3. **전체 기능이 모두 필요한 경우** - `custom_full.dart` 사용 (의존성 필요)
4. **폴더 삭제는 최후의 수단** - 대부분의 경우 기본 버전 사용으로 충분

## 예제

### 예제 1: 위젯 + 핵심 유틸리티만

```dart
import 'package:your_project/custom/widgets.dart';
import 'package:your_project/custom/utils_core.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "홈"),
      body: CustomColumn(
        children: [
          CustomText(CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd')),
          CustomButton(
            btnText: "확인",
            onCallBack: () {
              final unique = CustomCollectionUtil.unique([1, 2, 2, 3]);
              print(unique);  // [1, 2, 3]
            },
          ),
        ],
      ),
    );
  }
}
```

### 예제 2: 스토리지 유틸리티 추가 사용

```dart
import 'package:your_project/custom/widgets.dart';
import 'package:your_project/custom/utils_core.dart';
import 'package:your_project/custom/util/storage/custom_storage_util.dart';

// pubspec.yaml에 shared_preferences 추가 필요
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomStorageUtil.init();
  runApp(MyApp());
}
```

### 예제 3: 네트워크 유틸리티 추가 사용

```dart
import 'package:your_project/custom/widgets.dart';
import 'package:your_project/custom/utils_core.dart';
import 'package:your_project/custom/util/network/custom_network_util.dart';

// pubspec.yaml에 http 패키지 추가 필요
Future<void> fetchData() async {
  final response = await CustomNetworkUtil.get<User>(
    '/api/users/1',
    fromJson: (json) => User.fromJson(json),
  );
}
```
