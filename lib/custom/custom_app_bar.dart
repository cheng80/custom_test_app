import 'custom_common_util.dart';
import 'package:flutter/material.dart';

/// AppBar 위젯
///
/// 사용 예시:
/// ```dart
/// CustomAppBar(title: "홈")
/// CustomAppBar(title: "홈", backgroundColor: Colors.blue, actions: [IconButton(...)])
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar 제목 (필수)
  /// String인 경우 Text 위젯으로 자동 변환, Widget인 경우 그대로 사용
  final dynamic title;

  /// AppBar 배경색 (기본값: Colors.blue)
  final Color? backgroundColor;

  /// AppBar 전경색/아이콘 색상 (기본값: Colors.white)
  final Color? foregroundColor;

  /// 제목 중앙 정렬 여부 (기본값: true)
  final bool centerTitle;

  /// 왼쪽에 표시할 위젯 (뒤로가기 버튼 등)
  final Widget? leading;

  /// 오른쪽에 표시할 액션 버튼들
  final List<Widget>? actions;

  /// AppBar 높이 (기본값: kToolbarHeight)
  final double? toolbarHeight;

  /// 제목 텍스트 스타일
  final TextStyle? titleTextStyle;

  /// 자동으로 뒤로가기 버튼 표시 여부 (기본값: true, leading이 있으면 false)
  final bool automaticallyImplyLeading;

  CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.toolbarHeight,
    this.titleTextStyle,
    this.automaticallyImplyLeading = true,
  }) : assert(
         CustomCommonUtil.isString(title) || CustomCommonUtil.isWidget(title),
         'title은 String 또는 Widget이어야 합니다.',
       );

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.blue;
    final fgColor = foregroundColor ?? Colors.white;

    // title이 String인지 Widget인지 확인하고 처리
    Widget titleWidget;
    if (CustomCommonUtil.isString(title)) {
      // String인 경우 Text 위젯으로 변환
      titleWidget = Text(
        title as String,
        style:
            titleTextStyle ??
            TextStyle(
              color: fgColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      );
    } else {
      // Widget인 경우 그대로 사용
      titleWidget = title as Widget;
    }

    return AppBar(
      title: titleWidget,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading && leading == null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
