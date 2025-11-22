import 'package:flutter/material.dart';

/// 커스텀 AppBar 위젯 클래스
/// 자주 사용하는 속성들을 기본값으로 설정하여 간편하게 사용할 수 있습니다.
///
/// 사용 예시:
/// - 기본 사용: CustomAppBar(title: "홈")
/// - 색상 지정: CustomAppBar(title: "홈", backgroundColor: Colors.blue)
/// - 액션 버튼: CustomAppBar(title: "홈", actions: [IconButton(...)])
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar 제목 (필수)
  final String title;

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

  const CustomAppBar({
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
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.blue;
    final fgColor = foregroundColor ?? Colors.white;

    return AppBar(
      title: Text(
        title,
        style:
            titleTextStyle ??
            TextStyle(
              color: fgColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      ),
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
