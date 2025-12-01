import 'custom_button.dart';
import 'custom_text.dart';
import 'custom_common_util.dart';
import 'package:flutter/material.dart';

/// 다이얼로그 타입 enum
enum DialogType {
  /// 확인만 있는 다이얼로그 (단일 버튼)
  single,

  /// 확인/취소가 있는 다이얼로그 (이중 버튼)
  dual,

  /// 커스텀 버튼들을 사용하는 다이얼로그
  custom,
}

/// 다이얼로그 액션 아이템 클래스
/// 각 버튼의 정보를 담는 클래스입니다.
class DialogActionItem {
  /// 버튼에 표시할 텍스트 또는 위젯
  /// String인 경우 CustomText로 자동 변환, Widget인 경우 그대로 사용
  final dynamic label;

  /// 버튼 클릭 시 실행될 콜백
  final VoidCallback? onTap;

  /// 버튼 타입 (기본값: ButtonType.text)
  final ButtonType buttonType;

  /// 버튼 배경색
  final Color? backgroundColor;

  /// 버튼 전경색/텍스트 색상
  final Color? foregroundColor;

  /// 버튼 최소 크기
  final Size? minimumSize;

  /// 버튼 모서리 둥글기
  final double? borderRadius;

  /// 이 버튼 클릭 시 다이얼로그가 자동으로 닫힐지 여부 (기본값: true)
  final bool autoDismiss;

  DialogActionItem({
    required this.label,
    this.onTap,
    this.buttonType = ButtonType.text,
    this.backgroundColor,
    this.foregroundColor,
    this.minimumSize,
    this.borderRadius,
    this.autoDismiss = true,
  }) : assert(
         CustomCommonUtil.isString(label) || CustomCommonUtil.isWidget(label),
         'label은 String 또는 Widget이어야 합니다.',
       );
}

/// 다이얼로그 헬퍼 클래스
///
/// 사용 예시:
/// ```dart
/// CustomDialog.show(context, title: "알림", message: "메시지")
/// CustomDialog.show(context, title: "확인", message: "진행하시겠습니까?", type: DialogType.dual, onConfirm: () {})
/// ```
class CustomDialog {
  /// 다이얼로그를 표시하는 정적 메서드
  static Future<void> show(
    BuildContext context, {
    required dynamic title,
    required dynamic message,
    DialogType type = DialogType.single,
    String confirmText = "확인",
    String cancelText = "취소",
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool autoDismissOnConfirm = true,
    bool autoDismissOnCancel = true,
    List<DialogActionItem>? customActions,
    bool barrierDismissible = false,
    Color? backgroundColor,
    double? borderRadius,
    MainAxisAlignment actionsAlignment = MainAxisAlignment.center,
  }) {
    // title과 message가 String인지 Widget인지 확인
    assert(
      CustomCommonUtil.isString(title) || CustomCommonUtil.isWidget(title),
      'title은 String 또는 Widget이어야 합니다.',
    );
    assert(
      CustomCommonUtil.isString(message) || CustomCommonUtil.isWidget(message),
      'message는 String 또는 Widget이어야 합니다.',
    );

    // 커스텀 액션이 있으면 타입을 custom으로 설정
    final effectiveType = customActions != null && customActions.isNotEmpty
        ? DialogType.custom
        : type;

    // title Widget 생성
    Widget titleWidget;
    if (CustomCommonUtil.isString(title)) {
      titleWidget = CustomText(
        title as String,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
    } else {
      titleWidget = title as Widget;
    }

    // message Widget 생성
    Widget messageWidget;
    if (CustomCommonUtil.isString(message)) {
      messageWidget = CustomText(
        message as String,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      );
    } else {
      messageWidget = message as Widget;
    }

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? Colors.white,
          shape: borderRadius != null
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
          title: titleWidget,
          content: messageWidget,
          actionsAlignment: actionsAlignment,
          actions: _buildActions(
            ctx: ctx,
            type: effectiveType,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            autoDismissOnConfirm: autoDismissOnConfirm,
            autoDismissOnCancel: autoDismissOnCancel,
            customActions: customActions,
          ),
        );
      },
    );
  }

  /// 다이얼로그 액션 버튼들을 생성하는 메서드
  static List<Widget> _buildActions({
    required BuildContext ctx,
    required DialogType type,
    required String confirmText,
    required String cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool autoDismissOnConfirm = true,
    bool autoDismissOnCancel = true,
    List<DialogActionItem>? customActions,
  }) {
    if (type == DialogType.custom && customActions != null) {
      // 커스텀 버튼들
      return customActions.map((action) {
        return CustomButton(
          btnText: action.label,
          buttonType: action.buttonType,
          backgroundColor: action.backgroundColor,
          foregroundColor: action.foregroundColor,
          minimumSize: action.minimumSize ?? const Size(80, 40),
          borderRadius: action.borderRadius,
          onCallBack: () {
            action.onTap?.call();
            if (action.autoDismiss) {
              Navigator.pop(ctx);
            }
          },
        );
      }).toList();
    } else if (type == DialogType.single) {
      // 단일 버튼 (확인만)
      return [
        CustomButton(
          btnText: confirmText,
          backgroundColor: Colors.blue,
          minimumSize: const Size(100, 40),
          onCallBack: () {
            onConfirm?.call();
            if (autoDismissOnConfirm) {
              Navigator.pop(ctx);
            }
          },
        ),
      ];
    } else {
      // 이중 버튼 (확인/취소)
      return [
        CustomButton(
          btnText: cancelText,
          buttonType: ButtonType.outlined,
          backgroundColor: Colors.grey,
          minimumSize: const Size(80, 40),
          onCallBack: () {
            onCancel?.call();
            if (autoDismissOnCancel) {
              Navigator.pop(ctx);
            }
          },
        ),
        CustomButton(
          btnText: confirmText,
          backgroundColor: Colors.blue,
          minimumSize: const Size(80, 40),
          onCallBack: () {
            onConfirm?.call();
            if (autoDismissOnConfirm) {
              Navigator.pop(ctx);
            }
          },
        ),
      ];
    }
  }
}
