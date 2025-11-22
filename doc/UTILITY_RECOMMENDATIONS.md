# 유틸리티 클래스 추천 목록

Flutter/Dart 개발에서 자주 사용되는 유틸리티 클래스들을 정리했습니다.

## 현재 구현된 유틸리티

### CustomCommonUtil

- 위젯 관련 유틸리티 (String/Widget 변환 등)

---

## 추천 유틸리티 클래스

### 1. 날짜/시간 관련 유틸리티 (DateUtil)

**필요성**: ⭐⭐⭐⭐⭐ (매우 높음)

**주요 기능**:

- 날짜 포맷팅 (yyyy-MM-dd, yyyy년 MM월 dd일 등)
- 날짜 비교 (오늘인지, 며칠 전인지 등)
- 날짜 계산 (N일 후, N일 전 등)
- 시간대 변환
- 상대 시간 표시 ("방금 전", "5분 전", "3일 전" 등)

**예시 사용법**:

```dart
DateUtil.format(DateTime.now(), 'yyyy-MM-dd HH:mm:ss');
DateUtil.isToday(DateTime.now());
DateUtil.daysBetween(date1, date2);
DateUtil.toRelativeTime(DateTime.now().subtract(Duration(hours: 2)));
```

---

### 2. 문자열 관련 유틸리티 (StringUtil)

**필요성**: ⭐⭐⭐⭐⭐ (매우 높음)

**주요 기능**:

- 문자열 검증 (이메일, 전화번호, URL 등)
- 문자열 변환 (카멜케이스, 스네이크케이스 등)
- 문자열 자르기/줄바꿈 처리
- 문자열 포맷팅 (숫자 천단위 콤마 등)
- 문자열 치환/제거
- 한글 초성 추출

**예시 사용법**:

```dart
StringUtil.isEmail('test@example.com');
StringUtil.isPhoneNumber('010-1234-5678');
StringUtil.toCamelCase('hello_world'); // 'helloWorld'
StringUtil.formatNumber(1234567); // '1,234,567'
StringUtil.truncate('긴 텍스트...', maxLength: 10);
```

---

### 3. 숫자 관련 유틸리티 (NumberUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- 숫자 포맷팅 (천단위 콤마, 소수점 자리수 제한)
- 숫자 변환 (String → int/double, 안전한 변환)
- 숫자 검증 (양수인지, 범위 내인지 등)
- 통화 포맷팅 (원화, 달러 등)
- 퍼센트 계산

**예시 사용법**:

```dart
NumberUtil.format(1234567); // '1,234,567'
NumberUtil.safeParseInt('123'); // 123 or null
NumberUtil.formatCurrency(10000); // '10,000원'
NumberUtil.toPercent(0.25); // '25%'
```

---

### 4. 컬러 관련 유틸리티 (ColorUtil)

**필요성**: ⭐⭐⭐ (보통)

**주요 기능**:

- Hex ↔ Color 변환
- 밝기 조절 (밝게/어둡게)
- 대비 색상 계산 (텍스트 가독성)
- 그라데이션 생성
- 색상 혼합

**예시 사용법**:

```dart
ColorUtil.fromHex('#FF5733');
ColorUtil.toHex(Colors.blue);
ColorUtil.lighten(Colors.blue, 0.2);
ColorUtil.darken(Colors.blue, 0.2);
ColorUtil.getContrastColor(Colors.blue); // 흰색 또는 검은색
```

---

### 5. 검증(Validation) 관련 유틸리티 (ValidationUtil)

**필요성**: ⭐⭐⭐⭐⭐ (매우 높음)

**주요 기능**:

- 이메일 검증
- 전화번호 검증 (한국, 국제 등)
- 비밀번호 강도 검증
- 주민등록번호 검증
- 사업자등록번호 검증
- URL 검증
- 신용카드 번호 검증

**예시 사용법**:

```dart
ValidationUtil.isEmail('test@example.com');
ValidationUtil.isPhoneNumber('010-1234-5678');
ValidationUtil.validatePassword('password123'); // 강도 반환
ValidationUtil.isUrl('https://example.com');
```

---

### 6. 포맷팅 관련 유틸리티 (FormatUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- 파일 크기 포맷팅 (KB, MB, GB)
- 시간 포맷팅 (초 → 분:초, 시간:분:초)
- 거리 포맷팅 (미터 → km)
- 가격 포맷팅 (원화, 달러 등)
- 퍼센트 포맷팅

**예시 사용법**:

```dart
FormatUtil.formatFileSize(1024000); // '1.0 MB'
FormatUtil.formatDuration(Duration(seconds: 125)); // '2:05'
FormatUtil.formatDistance(1500); // '1.5 km'
FormatUtil.formatPrice(10000); // '10,000원'
```

---

### 7. 디바운싱/스로틀링 관련 유틸리티 (DebounceUtil / ThrottleUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- 디바운싱 (연속 호출 방지, 마지막 호출만 실행)
- 스로틀링 (일정 시간 간격으로만 실행)
- 검색 입력, 버튼 클릭 중복 방지 등에 유용

**예시 사용법**:

```dart
final debouncedSearch = DebounceUtil.debounce(
  (String query) => performSearch(query),
  Duration(milliseconds: 500),
);

final throttledScroll = ThrottleUtil.throttle(
  () => handleScroll(),
  Duration(milliseconds: 100),
);
```

---

### 8. 로컬 스토리지 관련 유틸리티 (StorageUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- SharedPreferences 래핑 (간편한 get/set)
- 타입 안전한 저장/불러오기
- 객체 직렬화/역직렬화 (JSON)
- 암호화 저장

**예시 사용법**:

```dart
await StorageUtil.setString('key', 'value');
final value = await StorageUtil.getString('key');
await StorageUtil.setObject('user', userData);
final user = await StorageUtil.getObject<User>('user');
```

---

### 9. 네트워크 관련 유틸리티 (NetworkUtil)

**필요성**: ⭐⭐⭐ (보통)

**주요 기능**:

- 인터넷 연결 확인
- 네트워크 타입 확인 (WiFi, 모바일 등)
- URL 파라미터 파싱/생성
- 헤더 관리

**예시 사용법**:

```dart
final isConnected = await NetworkUtil.isConnected();
final networkType = await NetworkUtil.getNetworkType();
final params = NetworkUtil.parseQueryString('?key=value');
```

---

### 10. 파일 관련 유틸리티 (FileUtil)

**필요성**: ⭐⭐⭐ (보통)

**주요 기능**:

- 파일 확장자 추출
- 파일 크기 확인
- 파일 존재 여부 확인
- 파일 읽기/쓰기 (간편한 래핑)
- 이미지 리사이징

**예시 사용법**:

```dart
final extension = FileUtil.getExtension('image.jpg'); // 'jpg'
final size = await FileUtil.getFileSize(file);
final exists = await FileUtil.exists(path);
```

---

### 11. 디바이스 관련 유틸리티 (DeviceUtil)

**필요성**: ⭐⭐⭐ (보통)

**주요 기능**:

- 플랫폼 확인 (iOS, Android, Web)
- 디바이스 정보 (모델명, OS 버전 등)
- 화면 크기/밀도 정보
- 키보드 높이 확인

**예시 사용법**:

```dart
final isIOS = DeviceUtil.isIOS();
final screenWidth = DeviceUtil.screenWidth;
final screenHeight = DeviceUtil.screenHeight;
final isTablet = DeviceUtil.isTablet();
```

---

### 12. 로깅 관련 유틸리티 (LogUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- 레벨별 로깅 (debug, info, warning, error)
- 릴리즈 모드에서 자동 비활성화
- 파일 로깅
- 로그 포맷팅

**예시 사용법**:

```dart
LogUtil.d('디버그 메시지');
LogUtil.i('정보 메시지');
LogUtil.w('경고 메시지');
LogUtil.e('에러 메시지', error: exception);
```

---

### 13. 암호화 관련 유틸리티 (CryptoUtil)

**필요성**: ⭐⭐⭐ (보통, 보안이 중요한 경우 높음)

**주요 기능**:

- 해시 생성 (MD5, SHA256 등)
- 암호화/복호화 (AES 등)
- Base64 인코딩/디코딩
- 랜덤 문자열 생성

**예시 사용법**:

```dart
final hash = CryptoUtil.sha256('password');
final encrypted = CryptoUtil.encrypt('data', 'key');
final decrypted = CryptoUtil.decrypt(encrypted, 'key');
final random = CryptoUtil.randomString(16);
```

---

### 14. 리스트/컬렉션 관련 유틸리티 (CollectionUtil)

**필요성**: ⭐⭐⭐ (보통)

**주요 기능**:

- 리스트가 비어있는지 확인 (null-safe)
- 리스트 중복 제거
- 리스트 그룹화
- 리스트 평탄화
- 리스트 필터링/매핑 간편화

**예시 사용법**:

```dart
if (CollectionUtil.isEmpty(list)) { ... }
final unique = CollectionUtil.unique(list);
final grouped = CollectionUtil.groupBy(list, (item) => item.category);
```

---

### 15. JSON 관련 유틸리티 (JsonUtil)

**필요성**: ⭐⭐⭐⭐ (높음)

**주요 기능**:

- 안전한 JSON 파싱
- 객체 → JSON 변환
- JSON → 객체 변환
- JSON 검증

**예시 사용법**:

```dart
final json = JsonUtil.encode(user);
final user = JsonUtil.decode<User>(jsonString);
final isValid = JsonUtil.isValid(jsonString);
```

---

## 우선순위 추천

### 높은 우선순위 (즉시 추가 권장)

1. **DateUtil** - 날짜/시간 처리는 거의 모든 앱에서 필요
2. **StringUtil** - 문자열 검증/변환은 매우 자주 사용
3. **ValidationUtil** - 폼 검증에 필수
4. **FormatUtil** - 데이터 표시에 필수

### 중간 우선순위 (필요시 추가)

5. **NumberUtil** - 숫자 포맷팅이 자주 필요한 경우
6. **DebounceUtil / ThrottleUtil** - 성능 최적화에 유용
7. **StorageUtil** - 로컬 데이터 저장이 필요한 경우
8. **LogUtil** - 디버깅에 유용

### 낮은 우선순위 (특수한 경우에만)

9. **ColorUtil** - 디자인 시스템이 복잡한 경우
10. **NetworkUtil** - 네트워크 상태 확인이 필요한 경우
11. **FileUtil** - 파일 처리가 많은 경우
12. **DeviceUtil** - 플랫폼별 분기가 많은 경우
13. **CryptoUtil** - 보안이 중요한 경우
14. **CollectionUtil** - 복잡한 리스트 처리가 많은 경우
15. **JsonUtil** - JSON 처리가 많은 경우

---

## 구현 시 고려사항

1. **타입 안전성**: null-safety를 고려한 안전한 구현
2. **에러 처리**: 예외 상황에 대한 적절한 처리
3. **성능**: 자주 호출되는 함수는 성능 최적화
4. **테스트**: 각 유틸리티 함수에 대한 단위 테스트 작성
5. **문서화**: 각 함수의 사용법과 예시를 문서화
6. **확장성**: 향후 기능 추가가 용이하도록 구조 설계

---

## 참고사항

- 일부 유틸리티는 외부 패키지로 대체 가능 (예: `intl` 패키지의 날짜 포맷팅)
- 프로젝트 특성에 맞는 유틸리티만 선택적으로 구현하는 것을 권장
- 모든 유틸리티를 한 번에 구현하기보다는, 필요에 따라 점진적으로 추가하는 것이 좋음
