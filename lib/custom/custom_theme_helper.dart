import 'package:flutter/material.dart';

/// Custom 위젯용 테마 색상 헬퍼
///
/// Theme.of(context) 기반 - lib/theme 의존 없음.
/// MaterialApp의 ThemeData만 있으면 동작합니다.
class CustomThemeHelper {
  CustomThemeHelper._();

  /// 기본 텍스트 색상 (onSurface)
  static Color textPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  /// 보조 텍스트 색상 (onSurfaceVariant)
  static Color textSecondary(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;

  /// 주요 포인트 색상
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  /// Primary 배경에 사용할 텍스트 색상
  static Color textOnPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  /// 카드/패널 배경 색상
  static Color cardBackground(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  /// 보조 포인트 색상 (accent)
  static Color accent(BuildContext context) =>
      Theme.of(context).colorScheme.tertiary;

  /// 칩 선택 배경 색상
  static Color chipSelectedBg(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  /// 칩 선택 텍스트 색상
  static Color chipSelectedText(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  /// SnackBar 기본 배경 색상 (inverseSurface)
  static Color snackBarBackground(BuildContext context) =>
      Theme.of(context).colorScheme.inverseSurface;

  /// SnackBar 기본 텍스트 색상 (onInverseSurface)
  static Color snackBarTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.onInverseSurface;
}
