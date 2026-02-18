import 'package:flutter/material.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// BottomSheet 사용 예제 페이지
class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "BottomSheet 예시",
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24, // 표준 Spacing 적용
            children: [
              CustomText(
                "BottomSheet 종합 예시",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),

              // 기본 사용 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "기본 BottomSheet",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "기본 BottomSheet 열기",
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomBottomSheet.show(
                        context: context,
                        title: "옵션 선택",
                        items: [
                          BottomSheetItem(
                            label: "옵션 1",
                            icon: Icons.check_circle,
                            onTap: () => CustomSnackBar.show(
                              context,
                              message: "옵션 1 선택됨",
                            ),
                          ),
                          BottomSheetItem(
                            label: "옵션 2",
                            icon: Icons.favorite,
                            onTap: () => CustomSnackBar.show(
                              context,
                              message: "옵션 2 선택됨",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // 메시지 포함 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "제목과 메시지 포함",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "메시지 포함 BottomSheet",
                    backgroundColor: Colors.indigo,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomBottomSheet.show(
                        context: context,
                        title: "계정 관리",
                        message: "원하는 작업을 선택하세요",
                        items: [
                          BottomSheetItem(
                            label: "프로필 수정",
                            icon: Icons.edit,
                            onTap: () =>
                                CustomSnackBar.show(context, message: "프로필 수정"),
                          ),
                          BottomSheetItem(
                            label: "비밀번호 변경",
                            icon: Icons.lock,
                            onTap: () => CustomSnackBar.show(
                              context,
                              message: "비밀번호 변경",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // 위험 작업 포함 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "위험 작업 포함",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "위험 작업 포함 BottomSheet",
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomBottomSheet.show(
                        context: context,
                        title: "계정 관리",
                        items: [
                          BottomSheetItem(
                            label: "프로필 수정",
                            icon: Icons.edit,
                            onTap: () =>
                                CustomSnackBar.show(context, message: "프로필 수정"),
                          ),
                          BottomSheetItem(
                            label: "계정 삭제",
                            icon: Icons.delete,
                            isDestructive: true,
                            onTap: () {
                              CustomDialog.show(
                                context,
                                title: "확인",
                                message: "정말로 계정을 삭제하시겠습니까?",
                                type: DialogType.dual,
                                onConfirm: () => CustomSnackBar.show(
                                  context,
                                  message: "계정이 삭제되었습니다",
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // 커스텀 위젯 사용 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "커스텀 위젯 사용",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "커스텀 위젯 BottomSheet",
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomBottomSheet.show(
                        context: context,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: CustomText(
                                "커스텀 위젯",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.info, color: p.primary),
                              title: CustomText("정보"),
                              subtitle: CustomText(
                                "커스텀 위젯을 사용한 예시입니다",
                                fontSize: 12,
                                color: p.textSecondary,
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: p.textSecondary,
                              ),
                              title: CustomText("설정"),
                              onTap: () {
                                Navigator.pop(context);
                                CustomSnackBar.show(context, message: "설정 선택됨");
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
