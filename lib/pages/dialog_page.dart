import '/custom/custom_app_bar.dart';
import '/custom/custom_button.dart';
import '/custom/custom_card.dart';
import '/custom/custom_column.dart';
import '/custom/custom_dialog.dart';
import '/custom/custom_padding.dart';
import '/custom/custom_text.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Dialog 예시", backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24,
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
                children: [
                  CustomText(
                    "단일 버튼 다이얼로그",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "알림 다이얼로그",
                    backgroundColor: Colors.blue,
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
                children: [
                  CustomText(
                    "이중 버튼 다이얼로그",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "확인 다이얼로그",
                    backgroundColor: Colors.teal,
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
                        onCancel: () {
                          print("취소됨");
                        },
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "삭제 확인",
                    backgroundColor: Colors.red,
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
                children: [
                  CustomText(
                    "버튼 정렬 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "가운데 정렬 (기본값)",
                    backgroundColor: Colors.purple,
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
                  CustomButton(
                    btnText: "오른쪽 정렬",
                    backgroundColor: Colors.deepPurple,
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "정렬 예시",
                        message: "버튼이 오른쪽 정렬됩니다.",
                        type: DialogType.dual,
                        actionsAlignment: MainAxisAlignment.end,
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "양쪽 정렬",
                    backgroundColor: Colors.purple.shade700,
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: "정렬 예시",
                        message: "버튼이 양쪽에 정렬됩니다.",
                        type: DialogType.dual,
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                      );
                    },
                  ),
                ],
              ),

              // Widget 사용 예시
              CustomColumn(
                spacing: 12,
                children: [
                  CustomText(
                    "Widget 사용 예시",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    btnText: "Widget 다이얼로그",
                    backgroundColor: Colors.deepPurple,
                    onCallBack: () {
                      CustomDialog.show(
                        context,
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info, color: Colors.blue),
                            const SizedBox(width: 8),
                            CustomText(
                              "정보",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        message: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "이것은 Widget을 사용한 다이얼로그입니다.",
                              fontSize: 16,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              "제목과 메시지 모두 Widget으로 지정할 수 있습니다.",
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        type: DialogType.single,
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
            ],
          ),
        ),
      ),
    );
  }
}
