import 'package:flutter/material.dart';

/// Custom 위젯용 내부 설정 및 색상 관리
///
/// 외부 의존성 없이 단독으로 동작하며, 라이트/다크 모드에 대응합니다.
class CustomColors {
  CustomColors._();

  // --- 기본 고정 색상 정의 (Material 2 스타일의 선명한 색상) ---
  static const Color pureBlue = Color(0xFF1976D2);
  static const Color pureRed = Color(0xFFD32F2F);
  static const Color pureGrey = Color(0xFF757575);
  static const Color pureWhite = Colors.white;
  static const Color pureBlack = Color(0xFF212121);

  // --- 라이트/다크 대응 색상 세트 ---

  // 주요 포인트 색상
  static Color primaryLight = pureBlue;
  static Color primaryDark = const Color(0xFF90CAF9);

  // 보조 포인트 색상
  static Color accentLight = const Color(0xFFFF9800);
  static Color accentDark = const Color(0xFFFFB74D);

  // 배경 색상
  static Color backgroundLight = const Color(0xFFF5F5F5);
  static Color backgroundDark = const Color(0xFF121212);

  // 카드/패널 배경
  static Color cardLight = Colors.white;
  static Color cardDark = const Color(0xFF1E1E1E);

  // 텍스트 색상
  static Color textPrimaryLight = const Color(0xFF212121);
  static Color textPrimaryDark = Colors.white;

  static Color textSecondaryLight = const Color(0xFF757575);
  static Color textSecondaryDark = const Color(0xFFB0B0B0);

  // --- 반응형 Getter (BuildContext 기반) ---

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color getPrimary(BuildContext context) =>
      isDark(context) ? primaryDark : primaryLight;

  static Color getAccent(BuildContext context) =>
      isDark(context) ? accentDark : accentLight;

  static Color getBackground(BuildContext context) =>
      isDark(context) ? backgroundDark : backgroundLight;

  static Color getCardBackground(BuildContext context) =>
      isDark(context) ? cardDark : cardLight;

  static Color getTextPrimary(BuildContext context) =>
      isDark(context) ? textPrimaryDark : textPrimaryLight;

  static Color getTextSecondary(BuildContext context) =>
      isDark(context) ? textSecondaryDark : textSecondaryLight;

  /// [사용자 선택 사항] 다른 앱의 ThemeData와 동기화하고 싶을 때 호출
  ///
  /// ## 용도
  /// custom 폴더를 다른 앱에 복사해서 사용할 때,
  /// 그 앱의 ThemeData(colorScheme)에 정의된 색상을
  /// CustomColors의 색상값에 덮어써서 자동으로 맞춰주는 메서드입니다.
  ///
  /// ## 언제 필요한가?
  /// - custom 위젯을 다른 프로젝트에 복사 → 그 앱의 테마 색상에 맞추고 싶을 때
  /// - CustomColors의 색상을 직접 하드코딩하지 않고, 앱 테마에서 자동으로 가져오고 싶을 때
  ///
  /// ## 언제 불필요한가?
  /// - 이 프로젝트처럼 AppThemeColors/ThemeProvider로 별도 테마 관리 중일 때
  /// - CustomColors의 색상을 직접 수정해서 쓸 때
  ///
  /// ## 호출 위치
  /// MaterialApp의 builder 또는 앱 최상위 위젯의 build() 내에서 호출합니다.
  ///
  /// ```dart
  /// // 방법 1: MaterialApp의 builder에서 호출
  /// MaterialApp(
  ///   theme: myAppTheme,
  ///   builder: (context, child) {
  ///     CustomColors.syncWithTheme(context);
  ///     return child!;
  ///   },
  /// );
  ///
  /// // 방법 2: 앱 최상위 위젯에서 호출
  /// @override
  /// Widget build(BuildContext context) {
  ///   CustomColors.syncWithTheme(context);
  ///   return Scaffold(...);
  /// }
  /// ```
  ///
  /// ## 구현 예시
  /// 아래 주석을 해제하고 필요한 항목만 매핑하세요.
  static void syncWithTheme(BuildContext context) {
    // final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;
    //
    // // 앱 테마 → CustomColors 동기화
    // primaryLight = colorScheme.primary;
    // primaryDark = colorScheme.primary;
    // accentLight = colorScheme.secondary;
    // accentDark = colorScheme.secondary;
    // backgroundLight = colorScheme.surface;
    // backgroundDark = colorScheme.surface;
    // cardLight = colorScheme.surfaceContainerLowest;
    // cardDark = colorScheme.surfaceContainerLowest;
    // textPrimaryLight = colorScheme.onSurface;
    // textPrimaryDark = colorScheme.onSurface;
    // textSecondaryLight = colorScheme.onSurfaceVariant;
    // textSecondaryDark = colorScheme.onSurfaceVariant;
  }
}
