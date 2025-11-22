# 네트워크 통신 클래스 설계

## 개요

외부 API 호출을 위한 네트워크 통신 유틸리티 클래스 설계안입니다.

## 패키지 선택

### 옵션 1: `http` 패키지 (기본)

- **장점**:
  - Flutter 공식 패키지
  - 가볍고 간단함
  - 기본 기능 충분
- **단점**:
  - 인터셉터 기능 없음
  - 자동 재시도 기능 없음

### 옵션 2: `dio` 패키지 (고급)

- **장점**:
  - 인터셉터 지원
  - 자동 재시도
  - 요청/응답 변환기
  - 파일 업로드/다운로드
  - 더 많은 기능
- **단점**:
  - 패키지 크기가 더 큼
  - 학습 곡선이 있음

**추천**: `http` 패키지로 시작 (필요시 `dio`로 업그레이드)

## 클래스 구조

### CustomNetworkUtil

```dart
class CustomNetworkUtil {
  // 기본 설정
  static String? baseUrl;
  static Map<String, String> defaultHeaders = {};
  static Duration timeout = Duration(seconds: 30);

  // GET 요청
  static Future<NetworkResponse<T>> get<T>(
    String endpoint,
    {
      Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      T Function(Map<String, dynamic>)? fromJson,
    }
  );

  // POST 요청
  static Future<NetworkResponse<T>> post<T>(
    String endpoint,
    {
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      T Function(Map<String, dynamic>)? fromJson,
    }
  );

  // PUT 요청
  static Future<NetworkResponse<T>> put<T>(
    String endpoint,
    {
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      T Function(Map<String, dynamic>)? fromJson,
    }
  );

  // DELETE 요청
  static Future<NetworkResponse<T>> delete<T>(
    String endpoint,
    {
      Map<String, String>? headers,
      T Function(Map<String, dynamic>)? fromJson,
    }
  );

  // PATCH 요청
  static Future<NetworkResponse<T>> patch<T>(
    String endpoint,
    {
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      T Function(Map<String, dynamic>)? fromJson,
    }
  );
}
```

### NetworkResponse

```dart
class NetworkResponse<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, String>? headers;

  NetworkResponse({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
    this.headers,
  });
}
```

## JsonUtil 연동

### 요청 데이터 변환

```dart
// POST 요청 시 객체를 JSON으로 변환
final user = User(name: '홍길동', age: 25);
final jsonBody = CustomJsonUtil.toJson(user);
// 또는
final jsonBody = CustomJsonUtil.encode(user.toJson());
```

### 응답 데이터 파싱

```dart
// 응답 JSON을 객체로 변환
final response = await CustomNetworkUtil.get<User>(
  '/api/users/1',
  fromJson: (json) => User.fromJson(json),
);
```

## 주요 기능

### 1. 기본 HTTP 메서드

- GET, POST, PUT, DELETE, PATCH

### 2. 헤더 관리

- 기본 헤더 설정
- 요청별 헤더 오버라이드
- 인증 토큰 자동 추가

### 3. JSON 변환 (JsonUtil 활용)

- 요청 데이터: 객체 → JSON
- 응답 데이터: JSON → 객체

### 4. 에러 처리

- 네트워크 에러
- HTTP 상태 코드 에러
- JSON 파싱 에러
- 타임아웃 에러

### 5. 쿼리 파라미터

- GET 요청 시 쿼리 파라미터 자동 변환

### 6. 타임아웃 설정

- 기본 타임아웃 설정
- 요청별 타임아웃 오버라이드

## 사용 예시

### 기본 사용

```dart
// GET 요청
final response = await CustomNetworkUtil.get<Map<String, dynamic>>(
  '/api/users',
);

if (response.success) {
  print(response.data);
} else {
  print('에러: ${response.error}');
}
```

### 객체 변환

```dart
// GET 요청 (객체로 변환)
final response = await CustomNetworkUtil.get<User>(
  '/api/users/1',
  fromJson: (json) => User.fromJson(json),
);

if (response.success) {
  final user = response.data;
  print('사용자: ${user?.name}');
}
```

### POST 요청

```dart
// POST 요청
final response = await CustomNetworkUtil.post<User>(
  '/api/users',
  body: {
    'name': '홍길동',
    'age': 25,
  },
  fromJson: (json) => User.fromJson(json),
);
```

### PUT 요청

```dart
// PUT 요청
final response = await CustomNetworkUtil.put<User>(
  '/api/users/1',
  body: {
    'name': '김철수',
    'age': 30,
  },
  fromJson: (json) => User.fromJson(json),
);
```

### DELETE 요청

```dart
// DELETE 요청
final response = await CustomNetworkUtil.delete(
  '/api/users/1',
);
```

### 쿼리 파라미터

```dart
// GET 요청 (쿼리 파라미터)
final response = await CustomNetworkUtil.get(
  '/api/users',
  queryParams: {
    'page': '1',
    'limit': '10',
  },
);
```

### 헤더 설정

```dart
// 기본 헤더 설정
CustomNetworkUtil.defaultHeaders = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer token',
};

// 요청별 헤더 오버라이드
final response = await CustomNetworkUtil.get(
  '/api/users',
  headers: {
    'Custom-Header': 'value',
  },
);
```

## 구현 고려사항

### 1. 에러 처리

- 네트워크 연결 실패
- HTTP 에러 상태 코드
- JSON 파싱 실패
- 타임아웃

### 2. 인증

- 토큰 자동 추가
- 토큰 갱신 (리프레시 토큰)
- 인증 실패 처리

### 3. 로깅

- 요청/응답 로깅 (디버그 모드)
- 에러 로깅

### 4. 재시도

- 네트워크 에러 시 자동 재시도
- 지수 백오프

### 5. 캐싱

- GET 요청 캐싱 (선택적)
- 캐시 만료 시간

## 파일 구조

```
lib/common/util/network/
├── custom_network_util.dart    # 메인 클래스
├── network_response.dart        # 응답 모델
├── network_error.dart           # 에러 모델
├── example.dart                 # 사용 예제
└── README.md                    # 문서
```

## 의존성

### http 패키지 사용 시

```yaml
dependencies:
  http: ^1.1.0
```

### dio 패키지 사용 시

```yaml
dependencies:
  dio: ^5.4.0
```

## 추천 구현 순서

1. **기본 구조**: NetworkResponse, 기본 GET/POST 메서드
2. **JsonUtil 연동**: 요청/응답 JSON 변환
3. **에러 처리**: 네트워크 에러, HTTP 에러 처리
4. **헤더 관리**: 기본 헤더, 인증 토큰
5. **고급 기능**: 재시도, 캐싱 (선택적)
