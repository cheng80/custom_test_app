/// 커스텀 위젯 라이브러리
///
/// 모든 커스텀 위젯을 export합니다.
/// 위젯만 필요한 경우 이 파일을 import하세요.
///
/// 사용 예시:
/// ```dart
/// import 'package:custom_test_app/custom/widgets.dart';
///
/// CustomText("안녕하세요")
/// CustomButton(btnText: "확인", onCallBack: () {})
/// ```
library;

// ============================================
// 기본 위젯 (의존성이 없는 순서로 export)
// ============================================

/// 텍스트 위젯
export 'custom_text.dart';

/// Column 위젯
export 'custom_column.dart';

/// Row 위젯
export 'custom_row.dart';

/// Padding 위젯
export 'custom_padding.dart';

/// 버튼 위젯 (CustomText, CustomCommonUtil 의존)
export 'custom_button.dart';

// ============================================
// 레이아웃 위젯
// ============================================

/// Card 위젯
export 'custom_card.dart';

/// Container 위젯
export 'custom_container.dart';

/// Image 위젯
export 'custom_image.dart';

/// IconButton 위젯
export 'custom_icon_button.dart';

/// ListView 위젯
export 'custom_list_view.dart';

// ============================================
// 입력 위젯
// ============================================

/// TextField 위젯
export 'custom_text_field.dart';

// ============================================
// 네비게이션 위젯
// ============================================

/// AppBar 위젯 (String/Widget 지원, CustomCommonUtil 의존)
export 'custom_app_bar.dart';

/// BottomNavigationBar 위젯 (CustomCommonUtil 의존)
export 'custom_bottom_nav_bar.dart';

/// TabBar 위젯
export 'custom_tab_bar.dart';

// ============================================
// 다이얼로그 및 알림
// ============================================

/// Dialog 헬퍼 (CustomButton, CustomText, CustomCommonUtil 의존)
export 'custom_dialog.dart';

/// SnackBar 헬퍼 (CustomText, CustomCommonUtil 의존)
export 'custom_snack_bar.dart';

/// ActionSheet 헬퍼 (CustomText, CustomCommonUtil 의존)
export 'custom_action_sheet.dart';
