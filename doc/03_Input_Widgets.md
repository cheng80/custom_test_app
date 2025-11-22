# 입력 위젯 클래스

## CustomTextField

텍스트 입력 필드를 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomTextField(
  controller: TextEditingController(),
  labelText: "이름",
)
```

### 주요 속성

| 속성              | 타입                         | 기본값                 | 설명                  |
| ----------------- | ---------------------------- | ---------------------- | --------------------- |
| `controller`      | `TextEditingController`      | 필수                   | 텍스트 입력 컨트롤러  |
| `labelText`       | `String?`                    | `null`                 | 라벨 텍스트           |
| `hintText`        | `String?`                    | `null`                 | 힌트 텍스트           |
| `obscureText`     | `bool`                       | `false`                | 비밀번호 입력 모드    |
| `keyboardType`    | `TextInputType?`             | `TextInputType.text`   | 키보드 타입           |
| `maxLength`       | `int?`                       | `null`                 | 최대 입력 길이        |
| `maxLines`        | `int?`                       | `1`                    | 최대 줄 수            |
| `readOnly`        | `bool`                       | `false`                | 읽기 전용 여부        |
| `enabled`         | `bool`                       | `true`                 | 입력 필드 활성화 여부 |
| `required`        | `bool`                       | `false`                | 필수 입력 여부        |
| `requiredMessage` | `String?`                    | "이 필드는 필수입니다" | 필수 입력 에러 메시지 |
| `validator`       | `String? Function(String?)?` | `null`                 | 입력 검증 함수        |
| `onChanged`       | `ValueChanged<String>?`      | `null`                 | 입력 변경 콜백        |
| `onSubmitted`     | `ValueChanged<String>?`      | `null`                 | 입력 완료 콜백        |

### 사용 예시

```dart
// 기본 사용
CustomTextField(
  controller: _nameController,
  labelText: "이름",
)

// 비밀번호 입력
CustomTextField(
  controller: _passwordController,
  labelText: "비밀번호",
  obscureText: true,
)

// 숫자 입력
CustomTextField(
  controller: _numberController,
  labelText: "숫자",
  keyboardType: TextInputType.number,
)

// 필수 입력
CustomTextField(
  controller: _emailController,
  labelText: "이메일",
  required: true,
  requiredMessage: "이메일을 입력해주세요",
)

// 검증 함수 사용
CustomTextField(
  controller: _phoneController,
  labelText: "전화번호",
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "전화번호를 입력해주세요";
    }
    if (!RegExp(r'^[0-9-]+$').hasMatch(value)) {
      return "올바른 전화번호 형식이 아닙니다";
    }
    return null;
  },
)
```

### 정적 메서드

#### `textCheck`

빈 입력값을 체크하는 정적 메서드입니다.

```dart
static bool textCheck(
  BuildContext context,
  TextEditingController controller,
)
```

**사용 예시:**

```dart
if (CustomTextField.textCheck(context, _nameController)) {
  // 입력값이 있음
  print("이름: ${_nameController.text}");
} else {
  // 입력값이 없음 (키보드도 자동으로 내려짐)
  print("이름을 입력해주세요");
}
```

### Form과 함께 사용

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      CustomTextField(
        controller: _nameController,
        labelText: "이름",
        required: true,
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
            // 폼 검증 성공
            print("제출 성공");
          }
        },
      ),
    ],
  ),
)
```
