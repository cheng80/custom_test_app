import 'package:flutter/material.dart';

import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// SnackBar & ActionSheet 사용 예제 페이지
class SnackBarActionSheetExample extends StatefulWidget {
  const SnackBarActionSheetExample({super.key});

  @override
  State<SnackBarActionSheetExample> createState() =>
      _SnackBarActionSheetExampleState();
}

class _SnackBarActionSheetExampleState
    extends State<SnackBarActionSheetExample> {
  int _snackBarCounter = 0;
  String _lastAction = "없음";

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "SnackBar & ActionSheet",
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24,
            children: [
              CustomText(
                "SnackBar & ActionSheet 예시",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),

              // SnackBar 예시
              CustomColumn(
                spacing: 12,
                children: [
                  CustomText(
                    "SnackBar 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "기본 SnackBar",
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () => CustomSnackBar.show(
                      context,
                      message: "기본 SnackBar 메시지입니다.",
                    ),
                  ),
                  CustomButton(
                    btnText: "성공 메시지",
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () => CustomSnackBar.showSuccess(
                      context,
                      message: "성공적으로 완료되었습니다!",
                    ),
                  ),
                  CustomButton(
                    btnText: "에러 메시지",
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () => CustomSnackBar.showError(
                      context,
                      message: "에러가 발생했습니다.",
                    ),
                  ),
                  CustomButton(
                    btnText: "액션 버튼 포함",
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomSnackBar.show(
                        context,
                        message: "메시지를 삭제하시겠습니까?",
                        actionLabel: "삭제",
                        onAction: () {
                          setState(() => _snackBarCounter++);
                          CustomSnackBar.showSuccess(
                            context,
                            message: "삭제되었습니다.",
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              // SnackBar 카운터
              CustomCard(
                padding: const EdgeInsets.all(16),
                child: CustomColumn(
                  spacing: 8,
                  children: [
                    CustomText(
                      "액션 버튼 클릭 횟수",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      '$_snackBarCounter',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),

              // ActionSheet 예시
              CustomColumn(
                spacing: 12,
                children: [
                  CustomText(
                    "ActionSheet 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "기본 ActionSheet",
                    backgroundColor: Colors.indigo,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomActionSheet.show(
                        context,
                        items: [
                          ActionSheetItem(
                            label: "옵션 1",
                            icon: Icons.check_circle,
                            onTap: () =>
                                setState(() => _lastAction = "옵션 1 선택됨"),
                          ),
                          ActionSheetItem(
                            label: "옵션 2",
                            icon: Icons.favorite,
                            onTap: () =>
                                setState(() => _lastAction = "옵션 2 선택됨"),
                          ),
                        ],
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "위험 작업 포함",
                    backgroundColor: Colors.red.shade700,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomActionSheet.show(
                        context,
                        title: "계정 관리",
                        items: [
                          ActionSheetItem(
                            label: "프로필 수정",
                            icon: Icons.edit,
                            onTap: () => setState(() => _lastAction = "프로필 수정"),
                          ),
                          ActionSheetItem(
                            label: "계정 삭제",
                            icon: Icons.delete,
                            isDestructive: true,
                            onTap: () => setState(() => _lastAction = "계정 삭제"),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // 마지막 선택된 액션 표시
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText('마지막 액션', fontWeight: FontWeight.bold),
                    CustomText(_lastAction, color: Colors.purple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
