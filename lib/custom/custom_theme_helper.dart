import 'package:flutter/material.dart';
import 'custom_config.dart';

/// Custom 위젯용 테마 색상 헬퍼
///
/// Theme.of(context)의 자동 해석을 방지하고 CustomColors에 정의된
/// 고정 또는 설정된 색상을 우선적으로 사용합니다.
class CustomThemeHelper {
  CustomThemeHelper._();

  /// 기본 텍스트 색상
  static Color textPrimary(BuildContext context) =>
      CustomColors.getTextPrimary(context);

  /// 보조 텍스트 색상
  static Color textSecondary(BuildContext context) =>
      CustomColors.getTextSecondary(context);

  /// 주요 포인트 색상
  static Color primary(BuildContext context) =>
      CustomColors.getPrimary(context);

  /// Primary 배경에 사용할 텍스트 색상
  static Color textOnPrimary(BuildContext context) => Colors.white; // 고정값 권장

  /// 카드/패널 배경 색상
  static Color cardBackground(BuildContext context) =>
      CustomColors.getCardBackground(context);

  /// 앱 전체 배경 색상 (Scaffold 등)
  static Color background(BuildContext context) =>
      CustomColors.getBackground(context);

  /// 보조 포인트 색상 (accent)
  static Color accent(BuildContext context) => CustomColors.getAccent(context);

  /// 칩 선택 배경 색상
  static Color chipSelectedBg(BuildContext context) =>
      CustomColors.getPrimary(context);

  /// 칩 선택 텍스트 색상
  static Color chipSelectedText(BuildContext context) => Colors.white;

  /// SnackBar 기본 배경 색상
  static Color snackBarBackground(BuildContext context) =>
      const Color(0xFF323232);

  /// SnackBar 기본 텍스트 색상
  static Color snackBarTextColor(BuildContext context) => Colors.white;
}
