# TODO - 유틸리티 클래스 구현 계획

## 완료된 항목 ✅

### 높은 우선순위

- ✅ **DateUtil** - 날짜/시간 관련 유틸리티 (CustomCommonUtil에 통합)
- ✅ **StringUtil** - 문자열 관련 유틸리티 (CustomCommonUtil에 통합)
- ✅ **ValidationUtil** - 검증 관련 유틸리티 (CustomCommonUtil에 통합)
- ✅ **FormatUtil** - 포맷팅 관련 유틸리티 (CustomCommonUtil에 통합)

### 중간 우선순위

- ✅ **NumberUtil** - 숫자 관련 유틸리티 (CustomCommonUtil에 통합)
- ✅ **DebounceUtil / ThrottleUtil** - 디바운싱/스로틀링 유틸리티 (TimerUtil에 통합)
- ✅ **StorageUtil** - 로컬 데이터 저장 유틸리티 (`lib/custom/external_util/storage/`)
- ✅ **CollectionUtil** - 컬렉션 조작 유틸리티 (`lib/common/util/collection/`)
- ✅ **TimerUtil** - 타이머 관리 유틸리티 (`lib/common/util/timer/`)
- ✅ **JsonUtil** - JSON 변환 유틸리티 (`lib/common/util/json/`)
- ✅ **NetworkUtil** - HTTP 통신 유틸리티 (`lib/custom/external_util/network/`) - http 패키지 사용

---

## 남은 구현 항목

### 높은 우선순위 (즉시 구현)

#### 1. CustomCupertinoDatePicker

**우선순위**: 높음 ⭐⭐⭐  
**파일**: `lib/custom/custom_cupertino_date_picker.dart`

**기능 설명**:

- iOS 스타일 날짜 선택기 위젯
- CupertinoDatePicker를 래핑하여 간편하게 사용
- 날짜, 시간, 날짜+시간 모드 지원

**주요 사용 사례**:

- iOS 스타일 날짜 선택
- 시간 선택
- 날짜와 시간 동시 선택

**예시 사용법**:

```dart
CustomCupertinoDatePicker(
  mode: CupertinoDatePickerMode.date,
  initialDateTime: DateTime.now(),
  onDateTimeChanged: (DateTime dateTime) {
    print('선택된 날짜: $dateTime');
  },
)
```

**상태**: 📋 진행 중

---

#### 2. CustomDatePicker

**우선순위**: 높음 ⭐⭐⭐  
**파일**: `lib/custom/custom_date_picker.dart`

**기능 설명**:

- Material Design 날짜 선택 다이얼로그 헬퍼
- showDatePicker를 래핑하여 간편하게 사용
- 기본값 설정 및 에러 처리 포함

**주요 사용 사례**:

- Material Design 스타일 날짜 선택
- 날짜 범위 선택
- 생년월일 선택

**예시 사용법**:

```dart
final selectedDate = await CustomDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
);
```

**상태**: 📋 진행 중

---

#### 3. CustomPickerView

**우선순위**: 높음 ⭐⭐⭐  
**파일**: `lib/custom/custom_picker_view.dart`

**기능 설명**:

- 일반적인 선택기 위젯
- 리스트에서 항목 선택
- 다중 선택 지원 (선택적)

**주요 사용 사례**:

- 단일 항목 선택
- 다중 항목 선택
- 커스텀 선택 UI

**예시 사용법**:

```dart
CustomPickerView<String>(
  items: ['옵션1', '옵션2', '옵션3'],
  selectedItem: '옵션1',
  onItemSelected: (String item) {
    print('선택된 항목: $item');
  },
)
```

**상태**: 📋 진행 중

---

#### 4. CustomGridView

**우선순위**: 높음 ⭐⭐⭐  
**파일**: `lib/custom/custom_grid_view.dart`

**기능 설명**:

- GridView.builder를 래핑하여 간편하게 사용
- 기본 spacing, padding 설정
- 크로스 액시스 카운트 자동 계산 지원

**주요 사용 사례**:

- 그리드 레이아웃
- 이미지 갤러리
- 상품 목록

**예시 사용법**:

```dart
CustomGridView(
  itemCount: 20,
  crossAxisCount: 2,
  itemBuilder: (context, index) => Card(...),
  spacing: 8,
  padding: EdgeInsets.all(16),
)
```

**상태**: 📋 진행 중

---

#### 5. CustomDropdownButton

**우선순위**: 높음 ⭐⭐⭐  
**파일**: `lib/custom/custom_dropdown_button.dart`

**기능 설명**:

- DropdownButton를 래핑하여 간편하게 사용
- String/Widget 지원
- 기본 스타일 적용

**주요 사용 사례**:

- 드롭다운 메뉴
- 선택 목록
- 필터링 옵션

**예시 사용법**:

```dart
CustomDropdownButton<String>(
  value: selectedValue,
  items: ['옵션1', '옵션2', '옵션3'],
  onChanged: (String? value) {
    setState(() {
      selectedValue = value;
    });
  },
)
```

**상태**: 📋 진행 중

---

### 중간 우선순위 (필요시 추가)

#### 8. AudioUtil

**우선순위**: 중간  
**파일**: `lib/common/util/audio/custom_audio_util.dart` (별도 파일)

**기능 설명**:

- 오디오 재생, 일시정지, 정지 제어
- ID 기반 여러 오디오 동시 관리 (TimerUtil과 유사한 구조)
- 볼륨, 재생 속도, 피치 조절
- 재생 상태 모니터링 (스트림 기반)
- 배경 재생 지원
- 재생 완료 콜백

**주요 사용 사례**:

- 효과음 재생 (버튼 클릭, 알림 등)
- 배경음악 재생
- 음성 안내 재생
- 게임 사운드 효과

**예시 사용법**:

```dart
// Asset 파일 재생
await CustomAudioUtil.playById(
  'click',
  AudioSource.asset('sounds/click.mp3'),
);

// 네트워크 URL 재생
await CustomAudioUtil.playById(
  'bgm',
  AudioSource.url('https://example.com/music.mp3'),
);

// 일시정지/재개
CustomAudioUtil.pauseById('bgm');
CustomAudioUtil.resumeById('bgm');

// 볼륨 조절 (0.0 ~ 1.0)
await CustomAudioUtil.setVolumeById('bgm', 0.5);

// 재생 속도 조절
await CustomAudioUtil.setPlaybackRateById('bgm', 1.5);

// 재생 상태 모니터링
CustomAudioUtil.getPlayerStateStreamById('bgm').listen((state) {
  print('재생 중: ${state.playing}');
});

// 재생 완료 콜백
CustomAudioUtil.setOnCompleteById('bgm', () {
  print('재생 완료');
});

// 정지
CustomAudioUtil.stopById('bgm');

// 모든 오디오 정지
CustomAudioUtil.stopAll();
```

**구현 필요 메서드**:

- `playById(String id, AudioSource source)` - ID로 오디오 재생
- `pauseById(String id)` - ID로 일시정지
- `resumeById(String id)` - ID로 재개
- `stopById(String id)` - ID로 정지
- `setVolumeById(String id, double volume)` - 볼륨 조절 (0.0 ~ 1.0)
- `setPlaybackRateById(String id, double rate)` - 재생 속도 조절
- `seekById(String id, Duration position)` - 재생 위치 이동
- `getPlayerStateStreamById(String id)` - 재생 상태 스트림
- `getPositionStreamById(String id)` - 재생 위치 스트림
- `setOnCompleteById(String id, VoidCallback callback)` - 재생 완료 콜백
- `stopAll()` - 모든 오디오 정지
- `getActivePlayerIds()` - 활성 플레이어 ID 목록
- `isPlaying(String id)` - 재생 중인지 확인
- `isPaused(String id)` - 일시정지 중인지 확인

**의존성**: `audioplayers` 또는 `just_audio` 패키지 필요

**참고 문서**: `lib_doc/Guide/AUDIO_GUIDE.md`

**상태**: 📋 계획 중

---

#### 6. LogUtil

**우선순위**: 중간  
**파일**: `lib/common/custom_log_util.dart` (별도 파일)

**기능 설명**:

- 레벨별 로깅 (debug, info, warning, error)
- 릴리즈 모드에서 자동 비활성화
- 파일 로깅 지원 (선택적)
- 로그 포맷팅

**주요 사용 사례**:

- 디버깅 정보 출력
- 에러 추적
- 사용자 행동 로깅
- 성능 모니터링

**예시 사용법**:

```dart
LogUtil.d('디버그 메시지');
LogUtil.i('정보 메시지');
LogUtil.w('경고 메시지');
LogUtil.e('에러 메시지', error: exception);

// 태그와 함께 사용
LogUtil.d('디버그 메시지', tag: 'API');
```

**구현 필요 메서드**:

- `d(String message, {String? tag, Object? error})` - 디버그 로그
- `i(String message, {String? tag})` - 정보 로그
- `w(String message, {String? tag, Object? error})` - 경고 로그
- `e(String message, {String? tag, Object? error, StackTrace? stackTrace})` - 에러 로그
- `setEnabled(bool enabled)` - 로깅 활성화/비활성화
- `setLogLevel(LogLevel level)` - 로그 레벨 설정

---

### 낮은 우선순위 (특수한 경우에만)

#### 7. ColorUtil

**우선순위**: 낮음  
**파일**: `lib/common/custom_color_util.dart` (별도 파일)

**기능 설명**:

- Hex ↔ Color 변환
- 밝기 조절 (밝게/어둡게)
- 대비 색상 계산 (텍스트 가독성)
- 그라데이션 생성
- 색상 혼합

**주요 사용 사례**:

- 디자인 시스템에서 색상 관리
- 다크모드 지원
- 접근성 향상 (가독성 개선)

---

#### 8. NetworkUtil

**우선순위**: 낮음  
**파일**: `lib/common/custom_network_util.dart` (별도 파일)

**기능 설명**:

- 인터넷 연결 확인
- 네트워크 타입 확인 (WiFi, 모바일 등)
- URL 파라미터 파싱/생성
- 헤더 관리

**의존성**: `connectivity_plus` 패키지 필요

---

#### 9. FileUtil

**우선순위**: 낮음  
**파일**: `lib/common/custom_file_util.dart` (별도 파일)

**기능 설명**:

- 파일 확장자 추출
- 파일 크기 확인
- 파일 존재 여부 확인
- 파일 읽기/쓰기 (간편한 래핑)
- 이미지 리사이징

**의존성**: `path_provider`, `image` 패키지 필요 (이미지 리사이징 시)

---

#### 10. DeviceUtil

**우선순위**: 낮음  
**파일**: `lib/common/custom_device_util.dart` (별도 파일)

**기능 설명**:

- 플랫폼 확인 (iOS, Android, Web)
- 디바이스 정보 (모델명, OS 버전 등)
- 화면 크기/밀도 정보
- 키보드 높이 확인

**의존성**: `device_info_plus` 패키지 필요

---

#### 11. CryptoUtil

**우선순위**: 낮음  
**파일**: `lib/common/custom_crypto_util.dart` (별도 파일)

**기능 설명**:

- 해시 생성 (MD5, SHA256 등)
- 암호화/복호화 (AES 등)
- Base64 인코딩/디코딩
- 랜덤 문자열 생성

**의존성**: `crypto`, `encrypt` 패키지 필요

---

---

#### 12. JsonUtil

**우선순위**: 낮음  
**파일**: `lib/common/util/json/custom_json_util.dart` (별도 파일)

**기능 설명**:

- **저장소와 무관한 순수 JSON 변환 유틸리티**
- StorageUtil의 JSON 기능은 저장소(SharedPreferences)에 저장/불러오기용
- JsonUtil은 API 응답 파싱, 네트워크 통신 등 저장소 없이 JSON 변환이 필요한 경우 사용
- 안전한 JSON 파싱 (에러 처리)
- 객체 → JSON 변환
- JSON → 객체 변환
- JSON 검증 (유효성 확인)
- JSON 포맷팅 (보기 좋게 정리)
- JSON 병합/수정

**StorageUtil과의 차이점**:

- **StorageUtil**: 저장소에 저장/불러오기 + JSON 변환 (저장소 연동 필수)
- **JsonUtil**: 순수 JSON 변환만 (저장소와 무관)

**주요 사용 사례**:

- API 응답 파싱
- 네트워크 통신 (HTTP 요청/응답)
- JSON 문자열 검증
- JSON 포맷팅 (디버깅용)
- JSON 객체 병합/수정

**예시 사용법**:

```dart
// API 응답 파싱
final response = await http.get(url);
final user = CustomJsonUtil.fromJson<User>(response.body, (json) => User.fromJson(json));

// JSON 문자열 검증
if (CustomJsonUtil.isValid(jsonString)) {
  final data = CustomJsonUtil.decode(jsonString);
}

// JSON 포맷팅
final formatted = CustomJsonUtil.format(jsonString);

// JSON 병합
final merged = CustomJsonUtil.merge(json1, json2);
```

**의존성**: `dart:convert` (기본 제공)

**상태**: ✅ 완료 (`lib/common/util/json/`)

**참고**: StorageUtil에 이미 JSON 직렬화/역직렬화가 있지만, 이는 저장소 연동용입니다. JsonUtil은 저장소와 무관한 순수 JSON 변환 유틸리티입니다.

---

#### 13. NetworkUtil

**우선순위**: 중간  
**파일**: `lib/custom/external_util/network/custom_network_util.dart` (별도 파일)

**기능 설명**:

- HTTP 통신 유틸리티 (GET, POST, PUT, DELETE, PATCH)
- JsonUtil과 연동하여 요청/응답 JSON 변환
- 헤더 관리 (기본 헤더, 인증 토큰)
- 에러 처리 (네트워크 에러, HTTP 에러, JSON 파싱 에러)
- 타임아웃 설정
- 쿼리 파라미터 자동 변환

**주요 사용 사례**:

- 외부 API 호출
- RESTful API 통신
- 서버와 데이터 주고받기
- 인증 토큰 관리

**예시 사용법**:

```dart
// GET 요청
final response = await CustomNetworkUtil.get<User>(
  '/api/users/1',
  fromJson: (json) => User.fromJson(json),
);

// POST 요청
final response = await CustomNetworkUtil.post<User>(
  '/api/users',
  body: {'name': '홍길동', 'age': 25},
  fromJson: (json) => User.fromJson(json),
);

// PUT 요청
final response = await CustomNetworkUtil.put<User>(
  '/api/users/1',
  body: {'name': '김철수'},
  fromJson: (json) => User.fromJson(json),
);

// DELETE 요청
final response = await CustomNetworkUtil.delete('/api/users/1');
```

**구현 필요 메서드**:

- `get<T>(String endpoint, {...})` - GET 요청
- `post<T>(String endpoint, {...})` - POST 요청
- `put<T>(String endpoint, {...})` - PUT 요청
- `delete<T>(String endpoint, {...})` - DELETE 요청
- `patch<T>(String endpoint, {...})` - PATCH 요청
- `setBaseUrl(String url)` - 기본 URL 설정
- `setDefaultHeaders(Map<String, String> headers)` - 기본 헤더 설정
- `setAuthToken(String token)` - 인증 토큰 설정

**의존성**: `http: ^1.1.0` 패키지 필요

**참고 문서**: `lib_doc/Guide/NETWORK_UTIL_DESIGN.md`

**상태**: ✅ 완료 (`lib/custom/external_util/network/`) - http 패키지 사용

---

## 구현 우선순위 요약

### 즉시 구현 권장 (중간 우선순위)

1. **AudioUtil** - 사운드 재생이 필요한 경우 필수
2. **LogUtil** - 디버깅에 유용

### 필요시 구현 (낮은 우선순위)

1. **ColorUtil** - 디자인 시스템이 복잡한 경우
2. **FileUtil** - 파일 처리가 많은 경우
3. **DeviceUtil** - 플랫폼별 분기가 많은 경우
4. **CryptoUtil** - 보안이 중요한 경우

---

## 구현 시 고려사항

1. **의존성 최소화**: 가능한 한 외부 패키지 없이 구현
2. **타입 안전성**: null-safety를 고려한 안전한 구현
3. **에러 처리**: 예외 상황에 대한 적절한 처리
4. **성능**: 자주 호출되는 함수는 성능 최적화
5. **문서화**: 각 함수의 사용법과 예시를 문서화
6. **테스트**: 각 유틸리티 함수에 대한 단위 테스트 작성

---

## 고도화 개발 예정 항목

### NetworkUtil 고도화 (dio 패키지 마이그레이션)

**현재 상태**: http 패키지 사용 중

**고도화 목표**: dio 패키지로 마이그레이션하여 고급 기능 추가

**추가 예정 기능**:

- **인터셉터**: 요청/응답 전처리, 로깅, 에러 처리
- **자동 재시도**: 네트워크 에러 시 자동 재시도 (지수 백오프)
- **요청 취소**: 진행 중인 요청 취소 기능
- **파일 업로드/다운로드**: 멀티파트 업로드, 진행률 추적
- **응답 변환기**: 자동 JSON 변환, 커스텀 변환기
- **캐싱**: 요청 결과 캐싱 (선택적)
- **동시 요청 제한**: 동시 요청 수 제한
- **요청 큐**: 요청 순서 관리

**의존성**: `dio: ^5.4.0` 패키지 필요

**예상 구현 시기**: 필요 시 (고급 기능이 필요한 경우)

---

## 참고사항

- 각 유틸리티는 필요에 따라 점진적으로 추가하는 것을 권장
- 프로젝트 특성에 맞는 유틸리티만 선택적으로 구현
- 외부 패키지가 필요한 경우, 의존성을 명확히 문서화

---

## 구조 개선 계획

### 단일 Import 구조 구현 (방법 2) ✅ 진행 중

**목표**: GetX처럼 `import 'package:custom_test_app/custom.dart';` 하나로 모든 위젯과 유틸리티 사용 가능

**구조**:

```
lib/
├── custom.dart                    # 편의용: widgets + utils 모두 export
└── common/
    ├── widgets.dart               # 위젯만 export
    ├── utils_core.dart            # 핵심 유틸리티만 export (의존성 없음)
    └── util/                      # 유틸리티 폴더
        ├── storage/               # 스토리지 유틸리티
        └── network/               # 네트워크 유틸리티
    ├── custom_full.dart           # 전체 기능 export (의존성 필요)
    └── ... (기존 파일들 그대로)
```

**사용 방법**:

```dart
// 위젯만 필요한 경우
import 'package:custom_test_app/common/widgets.dart';

// 유틸리티만 필요한 경우
import 'package:custom_test_app/custom/utils_core.dart';

// 둘 다 필요한 경우
import 'package:custom_test_app/custom.dart';
```

**상태**: 📋 진행 중

---

### 향후 리팩토링 계획 (방법 3) 🔮

**목표**: 위젯을 카테고리별 폴더로 재구성하여 더 체계적인 구조 만들기

**구조**:

```
lib/
├── custom.dart                    # widgets + utils 모두 export
└── common/
    ├── widgets.dart               # 위젯들 export (경로만 변경)
    ├── utils_core.dart            # 핵심 유틸리티 export
    └── util/                      # 유틸리티 폴더
        ├── storage/               # 스토리지 유틸리티
        └── network/               # 네트워크 유틸리티
    ├── custom_full.dart           # 전체 기능 export
    ├── widgets/
    │   ├── basic/                 # 기본 위젯 (Text, Button, Column, Row, Padding)
    │   ├── layout/                # 레이아웃 위젯 (Card, Container, Image, IconButton, ListView)
    │   ├── input/                 # 입력 위젯 (TextField)
    │   ├── navigation/            # 네비게이션 위젯 (AppBar, BottomNavBar, TabBar)
    │   └── dialog/                # 다이얼로그/알림 (Dialog, SnackBar, ActionSheet)
    └── utils/
        ├── custom_common_util.dart
        └── util/ (기존 구조 유지)
```

**장점**:

- 더 체계적인 파일 구조
- 카테고리별 관리 용이
- 확장성 향상

**전환 시 작업**:

- 파일 이동: 위젯 파일들을 카테고리별 폴더로 이동
- Export 파일 수정: `widgets.dart`, `utils_core.dart`의 export 경로 변경
- `custom_full.dart`에서 `external_util/storage/custom_storage_util.dart`, `external_util/network/custom_network_util.dart` 직접 export
- 사용자 코드 변경: 없음 (export 파일을 통해 접근하므로)

**상태**: 🔮 향후 리팩토링 예정 (방법 2 완료 후 진행)

---

## 전체 다국어 지원 적용

**우선순위**: 낮음 (최후 순위)  
**상태**: 📋 계획 중

**기능 설명**:

- 모든 커스텀 위젯과 유틸리티에 다국어 지원 추가
- intl 패키지를 활용한 자동 생성 방식 또는 직접 리소스 관리 방식 선택
- 모든 하드코딩된 문자열을 다국어 리소스로 변환

**참고**:

- DatePicker, CupertinoDatePicker 등은 이미 MaterialApp의 `localizationsDelegates`와 `supportedLocales` 설정으로 다국어 지원이 완료됨
- 이 항목은 위젯 내부의 모든 텍스트(버튼 라벨, 에러 메시지, 힌트 텍스트 등)에 대한 다국어 지원을 의미함

**주요 작업 내용**:

1. **다국어 리소스 파일 생성**

   - `lib/l10n/` 폴더 구조 생성
   - ARB 파일 또는 직접 리소스 파일 생성
   - 지원 언어: 한국어, 영어, 일본어 (필요시 확장)

2. **위젯별 다국어 적용**

   - CustomText: 다국어 문자열 지원
   - CustomButton: 버튼 텍스트 다국어화
   - CustomDialog: 다이얼로그 메시지 다국어화
   - CustomSnackBar: 알림 메시지 다국어화
   - CustomTextField: 힌트, 에러 메시지 다국어화
   - CustomAppBar: 제목 다국어화
   - 기타 모든 위젯의 하드코딩된 문자열

3. **유틸리티 다국어 적용**

   - CustomCommonUtil: 에러 메시지, 포맷팅 텍스트
   - 기타 유틸리티의 메시지들

4. **문서화**
   - 다국어 지원 가이드 작성
   - 사용 예시 추가

**예상 구현 방법**:

**옵션 1: intl 패키지 사용 (권장)**

```yaml
dependencies:
  intl: ^0.19.0
```

```dart
// l10n/app_en.arb
{
  "@@locale": "en",
  "confirm": "Confirm",
  "cancel": "Cancel",
  "@confirm": {
    "description": "Confirm button text"
  }
}

// l10n/app_ko.arb
{
  "@@locale": "ko",
  "confirm": "확인",
  "cancel": "취소"
}
```

**옵션 2: 직접 리소스 관리**

```dart
// lib/l10n/strings.dart
class Strings {
  static String getString(BuildContext context, String key) {
    // 로케일 기반 문자열 반환
  }
}
```

**구현 필요 사항**:

- 다국어 리소스 파일 구조 설계
- 모든 위젯의 하드코딩된 문자열 식별 및 리소스화
- 다국어 지원 유틸리티 클래스 또는 Extension 생성
- 테스트 및 검증

**의존성**: `intl: ^0.19.0` (옵션 1 선택 시)

**상태**: 📋 계획 중 (최후 순위)
