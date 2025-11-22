import 'package:flutter/material.dart';

/// 커스텀 TextField 위젯 클래스
/// 자주 사용하는 속성들을 기본값으로 설정하여 간편하게 사용할 수 있습니다.
///
/// 사용 예시:
/// - 기본 사용: CustomTextField(controller: controller, labelText: "입력하세요")
/// - 필수 입력: CustomTextField(controller: controller, labelText: "아이디", required: true)
/// - 비밀번호: CustomTextField(controller: controller, labelText: "비밀번호", obscureText: true)
/// - 숫자 입력: CustomTextField(controller: controller, labelText: "숫자", keyboardType: TextInputType.number)
class CustomTextField extends StatelessWidget {
  /// 텍스트 입력 컨트롤러 (필수)
  final TextEditingController controller;

  /// 라벨 텍스트
  final String? labelText;

  /// 힌트 텍스트
  final String? hintText;

  /// 비밀번호 입력 모드 (기본값: false)
  final bool obscureText;

  /// 키보드 타입 (기본값: TextInputType.text)
  final TextInputType? keyboardType;

  /// 최대 입력 길이
  final int? maxLength;

  /// 최대 줄 수 (기본값: 1)
  final int? maxLines;

  /// 읽기 전용 여부 (기본값: false)
  final bool readOnly;

  /// 입력 필드 활성화 여부 (기본값: true)
  final bool enabled;

  /// 포커스 노드
  final FocusNode? focusNode;

  /// 입력 필드 테두리 스타일 (기본값: OutlineInputBorder)
  final InputBorder? border;

  /// 입력 필드 배경색
  final Color? fillColor;

  /// 입력 필드 채우기 여부
  final bool? filled;

  /// 커스텀 InputDecoration
  final InputDecoration? decoration;

  /// 입력 변경 콜백
  final ValueChanged<String>? onChanged;

  /// 입력 완료 콜백
  final ValueChanged<String>? onSubmitted;

  /// 입력 검증 함수
  final String? Function(String?)? validator;

  /// 필수 입력 여부 (기본값: false)
  /// true로 설정하면 빈 값일 때 자동으로 검증하고 키보드를 내립니다.
  final bool required;

  /// 필수 입력일 때 표시할 에러 메시지 (기본값: "이 필드는 필수입니다")
  final String? requiredMessage;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.border,
    this.fillColor,
    this.filled,
    this.decoration,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.required = false,
    this.requiredMessage,
  });

  @override
  Widget build(BuildContext context) {
    // 기본 InputDecoration 생성
    final defaultDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: border ?? const OutlineInputBorder(),
      fillColor: fillColor,
      filled: filled,
    );

    // 사용자가 커스텀 decoration을 제공한 경우, 기본 decoration과 병합
    final finalDecoration = decoration != null
        ? defaultDecoration.copyWith(
            labelText: decoration!.labelText ?? labelText,
            hintText: decoration!.hintText ?? hintText,
            border: decoration!.border ?? border ?? const OutlineInputBorder(),
            fillColor: decoration!.fillColor ?? fillColor,
            filled: decoration!.filled ?? filled,
          )
        : defaultDecoration;

    // validator 생성 (required가 true이거나 사용자 validator가 있는 경우)
    String? Function(String?)? finalValidator;
    if (validator != null) {
      // 사용자 validator가 있으면 그것을 사용
      finalValidator = validator;
    } else if (required) {
      // required가 true이면 기본 validator 생성
      finalValidator = (String? value) {
        final str = value?.trim() ?? '';
        if (str.isEmpty) {
          // 키보드 내리기
          FocusScope.of(context).requestFocus(FocusNode());
          return requiredMessage ?? "이 필드는 필수입니다";
        }
        return null;
      };
    }

    // validator가 있으면 TextFormField 사용, 없으면 TextField 사용
    if (finalValidator != null) {
      return TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly,
        enabled: enabled,
        focusNode: focusNode,
        decoration: finalDecoration,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        validator: finalValidator,
      );
    }

    // 일반 TextField 사용
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
      enabled: enabled,
      focusNode: focusNode,
      decoration: finalDecoration,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// 빈 입력값을 체크하는 정적 메서드
  /// _textCheck() 메서드와 동일한 기능을 제공합니다.
  static bool textCheck(
    BuildContext context,
    TextEditingController controller,
  ) {
    final str = controller.text.trim();
    if (str.isEmpty) {
      // 키보드 내리기
      FocusScope.of(context).requestFocus(FocusNode());
      return false;
    }
    return true;
  }
}
