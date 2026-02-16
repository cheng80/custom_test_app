import 'custom_text.dart';
import 'custom_common_util.dart';
import 'custom_theme_helper.dart';
import 'package:flutter/material.dart';

OverlayEntry? _overlaySnackEntry;

/// Overlay 기반 스낵바 표시 (바텀시트/드로어 위에 표시)
/// Overlay.of(context, rootOverlay: true) 사용 - 외부 설정 불필요
void _showOverlaySnackBar(
  BuildContext context, {
  required Widget messageWidget,
  required Color backgroundColor,
  required Color textColor,
  Duration duration = const Duration(seconds: 3),
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  ),
  String? actionLabel,
  VoidCallback? onAction,
}) {
  final overlay = Overlay.of(context, rootOverlay: true);

  _overlaySnackEntry?.remove();
  _overlaySnackEntry = null;

  _overlaySnackEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: margin,
            child: _OverlaySnackBar(
              messageWidget: messageWidget,
              backgroundColor: backgroundColor,
              textColor: textColor,
              actionLabel: actionLabel,
              onAction: onAction,
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(_overlaySnackEntry!);

  Future<void>.delayed(duration, () {
    _overlaySnackEntry?.remove();
    _overlaySnackEntry = null;
  });
}

// SnackBar 헬퍼 클래스
//
// 사용 예시:
// ```dart
// CustomSnackBar.show(context, message: "메시지")
// CustomSnackBar.showSuccess(context, message: "성공했습니다")
// CustomSnackBar.showError(context, message: "에러가 발생했습니다")
// CustomSnackBar.showSuccess(context, message: "저장됨", overlay: true)  // 바텀시트 위에 표시
// ```
class CustomSnackBar {
  // SnackBar를 표시하는 정적 메서드
  static void show(
    BuildContext context, {
    required dynamic message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    EdgeInsetsGeometry? margin,
    bool overlay = false,
  }) {
    // message가 String인지 Widget인지 확인
    assert(
      CustomCommonUtil.isString(message) || CustomCommonUtil.isWidget(message),
      'message는 String 또는 Widget이어야 합니다.',
    );

    // message Widget 생성
    Widget messageWidget;
    if (CustomCommonUtil.isString(message)) {
      // String인 경우 CustomText로 변환
      messageWidget = CustomText(
        message as String,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor ?? CustomThemeHelper.snackBarTextColor(context),
      );
    } else {
      // Widget인 경우 그대로 사용
      messageWidget = message as Widget;
    }

    final effectiveColor =
        textColor ?? CustomThemeHelper.snackBarTextColor(context);
    final effectiveBg =
        backgroundColor ?? CustomThemeHelper.snackBarBackground(context);

    if (overlay) {
      _showOverlaySnackBar(
        context,
        messageWidget: messageWidget,
        backgroundColor: effectiveBg,
        textColor: effectiveColor,
        duration: duration,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actionLabel: actionLabel,
        onAction: onAction,
      );
      return;
    }

    // 전달받은 context를 그대로 사용
    // Dialog 내부에서 사용할 때는 원래 Scaffold의 context를 전달받아 사용
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: messageWidget,
        backgroundColor: effectiveBg,
        duration: duration,
        behavior: behavior,
        // margin은 floating에서만 사용 가능
        margin: behavior == SnackBarBehavior.floating ? margin : null,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: effectiveColor,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  // 성공 메시지를 표시하는 메서드 (녹색 배경)
  static void showSuccess(
    BuildContext context, {
    required dynamic message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    EdgeInsetsGeometry? margin,
    bool overlay = false,
  }) {
    show(
      context,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      behavior: behavior,
      margin: margin,
      overlay: overlay,
    );
  }

  // 에러 메시지를 표시하는 메서드 (빨간색 배경)
  static void showError(
    BuildContext context, {
    required dynamic message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    EdgeInsetsGeometry? margin,
    bool overlay = false,
  }) {
    show(
      context,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      behavior: behavior,
      margin: margin,
      overlay: overlay,
    );
  }

  // 경고 메시지를 표시하는 메서드 (주황색 배경)
  static void showWarning(
    BuildContext context, {
    required dynamic message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    EdgeInsetsGeometry? margin,
    bool overlay = false,
  }) {
    show(
      context,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      behavior: behavior,
      margin: margin,
      overlay: overlay,
    );
  }

  // 정보 메시지를 표시하는 메서드 (파란색 배경)
  static void showInfo(
    BuildContext context, {
    required dynamic message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    EdgeInsetsGeometry? margin,
    bool overlay = false,
  }) {
    show(
      context,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      behavior: behavior,
      margin: margin,
      overlay: overlay,
    );
  }
}

class _OverlaySnackBar extends StatefulWidget {
  final Widget messageWidget;
  final Color backgroundColor;
  final Color textColor;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _OverlaySnackBar({
    required this.messageWidget,
    required this.backgroundColor,
    required this.textColor,
    this.actionLabel,
    this.onAction,
  });

  @override
  State<_OverlaySnackBar> createState() => _OverlaySnackBarState();
}

class _OverlaySnackBarState extends State<_OverlaySnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _offset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: widget.messageWidget),
              if (widget.actionLabel != null && widget.onAction != null)
                TextButton(
                  onPressed: widget.onAction,
                  child: Text(
                    widget.actionLabel!,
                    style: TextStyle(color: widget.textColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
