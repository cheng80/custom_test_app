import 'package:custom_test_app/custom/custom_button.dart';
import 'package:custom_test_app/custom/custom_text.dart';
import 'package:custom_test_app/custom/custom_common_util.dart';
import 'package:flutter/material.dart';

/// 다이얼로그 타입 enum
enum DialogType {
  /// 확인만 있는 다이얼로그 (단일 버튼)
  single,

  /// 확인/취소가 있는 다이얼로그 (이중 버튼)
  dual,
}

/// 커스텀 다이얼로그 헬퍼 클래스
/// AlertDialog를 간편하게 표시할 수 있는 정적 메서드들을 제공합니다.
///
/// 사용 예시:
/// - 단일 버튼: CustomDialog.show(context, title: "알림", message: "메시지")
/// - 이중 버튼: CustomDialog.show(context, title: "확인", message: "진행하시겠습니까?", type: DialogType.dual, onConfirm: () {})
/// - 버튼 정렬: CustomDialog.show(context, title: "알림", message: "메시지", actionsAlignment: MainAxisAlignment.start)
/// - Widget 사용: CustomDialog.show(context, title: CustomText("알림", fontSize: 20), message: CustomText("메시지"))
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
            type: type,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
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
  }) {
    if (type == DialogType.single) {
      // 단일 버튼 (확인만)
      return [
        CustomButton(
          btnText: confirmText,
          backgroundColor: Colors.blue,
          minimumSize: const Size(100, 40),
          onCallBack: () {
            onConfirm?.call();
            Navigator.pop(ctx);
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
            Navigator.pop(ctx);
          },
        ),
        CustomButton(
          btnText: confirmText,
          backgroundColor: Colors.blue,
          minimumSize: const Size(80, 40),
          onCallBack: () {
            onConfirm?.call();
            Navigator.pop(ctx);
          },
        ),
      ];
    }
  }
}
