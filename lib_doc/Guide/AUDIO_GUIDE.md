# Flutter 사운드 제어 가이드

Flutter에서 사운드를 제어하는 방법에 대한 설명입니다.

## 주요 패키지

### 1. audioplayers

**가장 인기 있는 오디오 플레이어 패키지**

**특징:**

- 로컬 파일, 네트워크 URL 모두 지원
- 배경 재생 지원
- 여러 오디오 동시 재생 가능
- 간단한 API

**주요 기능:**

- 재생, 일시정지, 정지
- 볼륨 조절
- 재생 속도 조절
- 재생 위치 이동 (seek)
- 재생 완료 콜백

**의존성:**

```yaml
dependencies:
  audioplayers: ^6.0.0
```

**기본 사용법:**

```dart
final player = AudioPlayer();
await player.play(AssetSource('sounds/click.mp3'));
await player.pause();
await player.stop();
```

---

### 2. just_audio

**고급 기능이 필요한 경우 사용**

**특징:**

- 더 세밀한 제어 가능
- 플레이리스트 지원
- 오디오 스트리밍
- 오디오 효과 (이퀄라이저 등)
- 더 나은 성능

**주요 기능:**

- 재생, 일시정지, 정지
- 볼륨, 속도, 피치 조절
- 재생 위치 이동
- 플레이리스트 관리
- 오디오 스트림 처리

**의존성:**

```yaml
dependencies:
  just_audio: ^0.9.36
```

**기본 사용법:**

```dart
final player = AudioPlayer();
await player.setAsset('assets/sounds/click.mp3');
await player.play();
await player.pause();
await player.stop();
```

---

### 3. flutter_sound

**녹음 기능이 필요한 경우 사용**

**특징:**

- 오디오 재생 + 녹음 지원
- 다양한 오디오 포맷 지원
- 실시간 오디오 처리

**의존성:**

```yaml
dependencies:
  flutter_sound: ^9.2.13
```

---

## 오디오 소스 타입

### 1. Asset (로컬 파일)

```dart
// audioplayers
await player.play(AssetSource('sounds/click.mp3'));

// just_audio
await player.setAsset('assets/sounds/click.mp3');
```

### 2. 파일 경로

```dart
// audioplayers
await player.play(DeviceFileSource('/path/to/file.mp3'));

// just_audio
await player.setFilePath('/path/to/file.mp3');
```

### 3. 네트워크 URL

```dart
// audioplayers
await player.play(UrlSource('https://example.com/audio.mp3'));

// just_audio
await player.setUrl('https://example.com/audio.mp3');
```

### 4. 바이트 데이터

```dart
// just_audio
await player.setAudioSource(StreamAudioSource(...));
```

---

## 주요 기능

### 재생 제어

```dart
// 재생
await player.play();

// 일시정지
await player.pause();

// 정지 (재생 위치 초기화)
await player.stop();

// 재생 위치 이동
await player.seek(Duration(seconds: 30));
```

### 볼륨 및 속도

```dart
// 볼륨 조절 (0.0 ~ 1.0)
await player.setVolume(0.5);

// 재생 속도 조절 (0.5 ~ 2.0)
await player.setPlaybackRate(1.5);

// 피치 조절 (just_audio)
await player.setPitch(1.2);
```

### 재생 상태 모니터링

```dart
// 재생 상태 스트림
player.playerStateStream.listen((state) {
  print('재생 상태: ${state.playing}');
  print('처리 상태: ${state.processingState}');
});

// 재생 위치 스트림
player.positionStream.listen((position) {
  print('현재 위치: $position');
});

// 재생 완료 이벤트
player.onPlayerComplete.listen((_) {
  print('재생 완료');
});
```

---

## 배경 재생

### audioplayers

- 자동으로 배경 재생 지원
- `audio_service` 패키지와 함께 사용하면 더 나은 제어 가능

### just_audio

- `audio_service` 패키지와 함께 사용 권장
- 미디어 알림 표시 가능

---

## 권한 설정

### Android

`android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

### iOS

`ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
  <string>audio</string>
</array>
```

---

## 패키지 비교

| 기능           | audioplayers | just_audio | flutter_sound |
| -------------- | ------------ | ---------- | ------------- |
| 재생           | ✅           | ✅         | ✅            |
| 일시정지/정지  | ✅           | ✅         | ✅            |
| 볼륨/속도 조절 | ✅           | ✅         | ✅            |
| 배경 재생      | ✅           | ✅         | ✅            |
| 플레이리스트   | ❌           | ✅         | ❌            |
| 녹음           | ❌           | ❌         | ✅            |
| 오디오 효과    | 제한적       | ✅         | 제한적        |
| 성능           | 좋음         | 매우 좋음  | 좋음          |
| 사용 난이도    | 쉬움         | 보통       | 보통          |

---

## 추천 사용 시나리오

### 간단한 효과음/배경음악

→ **audioplayers** 추천

- 사용이 간단함
- 대부분의 경우 충분함

### 음악 플레이어 앱

→ **just_audio** 추천

- 플레이리스트 지원
- 더 나은 성능
- 세밀한 제어 가능

### 녹음 기능이 필요한 경우

→ **flutter_sound** 추천

- 녹음 + 재생 모두 지원

---

## 커스텀 래핑 클래스 설계 고려사항

만약 커스텀 오디오 유틸리티 클래스를 만들 경우:

1. **패키지 선택**: audioplayers 또는 just_audio 중 선택
2. **기본 기능**: 재생, 일시정지, 정지, 볼륨 조절
3. **ID 기반 관리**: 여러 오디오를 ID로 관리 (TimerUtil과 유사)
4. **재생 상태 관리**: 재생 중, 일시정지, 정지 상태 추적
5. **콜백 지원**: 재생 완료, 에러 처리
6. **배경 재생**: 선택적 지원
7. **플레이리스트**: 선택적 지원

---

## 참고 자료

- [audioplayers 패키지](https://pub.dev/packages/audioplayers)
- [just_audio 패키지](https://pub.dev/packages/just_audio)
- [flutter_sound 패키지](https://pub.dev/packages/flutter_sound)
- [audio_service 패키지](https://pub.dev/packages/audio_service) (배경 재생용)
