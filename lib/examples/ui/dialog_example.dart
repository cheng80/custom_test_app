import 'package:flutter/material.dart';

import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// Dialog 사용 예제 페이지
class DialogExample extends StatefulWidget {
  const DialogExample({super.key});

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(title: "Dialog 예시", backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24, // 표준 Spacing 적용
            children: [
              CustomText(
                "다이얼로그 종합 예시",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),

              // 단일 버튼 다이얼로그
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "단일 버튼 다이얼로그",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "알림 다이얼로그",
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "알림",
                        message: "단일 버튼 다이얼로그입니다.",
                        type: DialogType.single,
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "성공 메시지",
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "성공",
                        message: "작업이 성공적으로 완료되었습니다.",
                        type: DialogType.single,
                        confirmText: "확인",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "경고 메시지",
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "경고",
                        message: "주의가 필요한 상황입니다.",
                        type: DialogType.single,
                        confirmText: "알겠습니다",
                      );
                    },
                  ),
                ],
              ),

              // 이중 버튼 다이얼로그
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "이중 버튼 다이얼로그",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "확인 다이얼로그",
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "확인",
                        message: "진행하시겠습니까?",
                        type: DialogType.dual,
                        onConfirm: () {
                          setState(() {
                            _counter++;
                          });
                        },
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "삭제 확인",
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "삭제 확인",
                        message: "정말로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.",
                        type: DialogType.dual,
                        confirmText: "삭제",
                        cancelText: "취소",
                        onConfirm: () {
                          CustomDialog.show(
                            context,
                            title: "완료",
                            message: "삭제되었습니다.",
                            type: DialogType.single,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              // 버튼 정렬 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "버튼 정렬 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "가운데 정렬 (기본값)",
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "정렬 예시",
                        message: "버튼이 가운데 정렬됩니다.",
                        type: DialogType.dual,
                        actionsAlignment: MainAxisAlignment.center,
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "왼쪽 정렬",
                    backgroundColor: Colors.indigo,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "정렬 예시",
                        message: "버튼이 왼쪽 정렬됩니다.",
                        type: DialogType.dual,
                        actionsAlignment: MainAxisAlignment.start,
                      );
                    },
                  ),
                ],
              ),

              // 카운터 표시
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 8,
                  children: [
                    CustomText(
                      "확인 버튼 클릭 횟수",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      '$_counter',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              // 자동 닫힘 제어 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "자동 닫힘 제어 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "비동기 작업 후 닫기",
                    backgroundColor: Colors.cyan,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "처리 중",
                        message: "작업을 수행한 후 자동으로 닫힙니다...",
                        type: DialogType.single,
                        autoDismissOnConfirm: false,
                        confirmText: "처리 시작",
                        onConfirm: () async {
                          await Future.delayed(const Duration(seconds: 2));
                          if (context.mounted) {
                            Navigator.pop(context);
                            CustomDialog.show(
                              context,
                              title: "완료",
                              message: "작업이 완료되었습니다!",
                              type: DialogType.single,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),

              // 3개 버튼 가로 배치 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "복수 버튼 가로 배치",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "가로 배치 예제",
                    backgroundColor: Colors.teal.shade700,
                    minimumSize: const Size(double.infinity, 48),
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "작업 선택",
                        message: "원하는 작업을 선택해주세요.",
                        customActionGroups: [
                          DialogActionGroup(
                            actions: [
                              DialogActionItem(
                                label: "저장",
                                backgroundColor: Colors.green,
                                onTap: () => print("저장"),
                                autoDismiss: true,
                              ),
                              DialogActionItem(
                                label: "수정",
                                backgroundColor: Colors.blue,
                                onTap: () => print("수정"),
                                autoDismiss: true,
                              ),
                              DialogActionItem(
                                label: "취소",
                                buttonType: ButtonType.outlined,
                                backgroundColor: Colors.grey,
                                onTap: () {},
                                autoDismiss: true,
                              ),
                            ],
                            direction: Axis.horizontal,
                            spacing: 8,
                          ),
                        ],
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
