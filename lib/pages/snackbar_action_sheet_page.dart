import 'package:flutter/material.dart';

import '../custom/widgets.dart';
import '../theme/app_theme_colors.dart';

/// SnackBar & ActionSheet 사용 예제 페이지
class SnackBarActionSheetPage extends StatefulWidget {
  const SnackBarActionSheetPage({super.key});

  @override
  State<SnackBarActionSheetPage> createState() =>
      _SnackBarActionSheetPageState();
}

class _SnackBarActionSheetPageState extends State<SnackBarActionSheetPage> {
  int _snackBarCounter = 0;
  String _lastAction = "없음";

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "SnackBar & ActionSheet",
        backgroundColor: Colors.purple, // 예제용 색상 유지
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
                color: Colors.purple, // 예제용 색상 유지
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
                    backgroundColor: Colors.grey.shade700, // 예제용 색상 유지
                    onCallBack: () {
                      CustomSnackBar.show(
                        context,
                        message: "기본 SnackBar 메시지입니다.",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "성공 메시지",
                    backgroundColor: Colors.green,
                    onCallBack: () {
                      CustomSnackBar.showSuccess(
                        context,
                        message: "작업이 성공적으로 완료되었습니다!",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "에러 메시지",
                    backgroundColor: Colors.red,
                    onCallBack: () {
                      CustomSnackBar.showError(
                        context,
                        message: "에러가 발생했습니다. 다시 시도해주세요.",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "경고 메시지",
                    backgroundColor: Colors.orange,
                    onCallBack: () {
                      CustomSnackBar.showWarning(
                        context,
                        message: "주의가 필요한 상황입니다.",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "정보 메시지",
                    backgroundColor: Colors.blue,
                    onCallBack: () {
                      CustomSnackBar.showInfo(
                        context,
                        message: "이것은 정보 메시지입니다.",
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "액션 버튼 포함",
                    backgroundColor: Colors.teal,
                    onCallBack: () {
                      setState(() {
                        _snackBarCounter++;
                      });
                      CustomSnackBar.show(
                        context,
                        message: "메시지를 삭제하시겠습니까?",
                        actionLabel: "실행",
                        onAction: () {
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
                      "SnackBar 액션 버튼 클릭 횟수",
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

              const SizedBox(height: 16),

              // Widget 사용 예시
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: CustomColumn(
                  spacing: 16,
                  children: [
                    CustomText(
                      "🎨 Widget 사용 예시",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "SnackBar와 ActionSheet에서 Widget 사용",
                      fontSize: 14,
                      color: p.textSecondary,
                    ),
                    CustomButton(
                      btnText: "Widget SnackBar",
                      backgroundColor: Colors.indigo,
                      onCallBack: () {
                        CustomSnackBar.show(
                          context,
                          message: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              const SizedBox(width: 8),
                              CustomText(
                                "성공적으로 완료되었습니다!",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          backgroundColor: Colors.green,
                        );
                      },
                    ),
                    CustomButton(
                      btnText: "Widget ActionSheet",
                      backgroundColor: Colors.teal,
                      onCallBack: () {
                        CustomActionSheet.show(
                          context,
                          title: "선택하세요",
                          items: [
                            ActionSheetItem(
                              label: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  CustomText("수정", fontSize: 16),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  _lastAction = "수정 (Widget)";
                                });
                                CustomSnackBar.showSuccess(
                                  context,
                                  message: "수정 선택됨",
                                );
                              },
                            ),
                            ActionSheetItem(
                              label: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  const SizedBox(width: 8),
                                  CustomText(
                                    "삭제",
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              isDestructive: true,
                              onTap: () {
                                setState(() {
                                  _lastAction = "삭제 (Widget)";
                                });
                                CustomSnackBar.showError(
                                  context,
                                  message: "삭제 선택됨",
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

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
                    onCallBack: () {
                      CustomActionSheet.show(
                        context,
                        items: [
                          ActionSheetItem(
                            label: "옵션 1",
                            icon: Icons.check_circle,
                            onTap: () {
                              setState(() {
                                _lastAction = "옵션 1 선택됨";
                              });
                              CustomSnackBar.showSuccess(
                                context,
                                message: "옵션 1이 선택되었습니다.",
                              );
                            },
                          ),
                          ActionSheetItem(
                            label: "옵션 2",
                            icon: Icons.favorite,
                            onTap: () {
                              setState(() {
                                _lastAction = "옵션 2 선택됨";
                              });
                              CustomSnackBar.showSuccess(
                                context,
                                message: "옵션 2가 선택되었습니다.",
                              );
                            },
                          ),
                          ActionSheetItem(
                            label: "옵션 3",
                            icon: Icons.star,
                            onTap: () {
                              setState(() {
                                _lastAction = "옵션 3 선택됨";
                              });
                              CustomSnackBar.showSuccess(
                                context,
                                message: "옵션 3이 선택되었습니다.",
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "제목 포함 ActionSheet",
                    backgroundColor: Colors.deepPurple,
                    onCallBack: () {
                      CustomActionSheet.show(
                        context,
                        title: "사진 선택",
                        message: "사진을 가져올 방법을 선택하세요",
                        items: [
                          ActionSheetItem(
                            label: "카메라로 촬영",
                            icon: Icons.camera_alt,
                            onTap: () {
                              setState(() {
                                _lastAction = "카메라로 촬영";
                              });
                              CustomSnackBar.showInfo(
                                context,
                                message: "카메라를 엽니다.",
                              );
                            },
                          ),
                          ActionSheetItem(
                            label: "갤러리에서 선택",
                            icon: Icons.photo_library,
                            onTap: () {
                              setState(() {
                                _lastAction = "갤러리에서 선택";
                              });
                              CustomSnackBar.showInfo(
                                context,
                                message: "갤러리를 엽니다.",
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "위험 작업 포함",
                    backgroundColor: Colors.red.shade700,
                    onCallBack: () {
                      CustomActionSheet.show(
                        context,
                        title: "계정 관리",
                        items: [
                          ActionSheetItem(
                            label: "프로필 수정",
                            icon: Icons.edit,
                            onTap: () {
                              setState(() {
                                _lastAction = "프로필 수정";
                              });
                              CustomSnackBar.showInfo(
                                context,
                                message: "프로필 수정 화면으로 이동합니다.",
                              );
                            },
                          ),
                          ActionSheetItem(
                            label: "비밀번호 변경",
                            icon: Icons.lock,
                            onTap: () {
                              setState(() {
                                _lastAction = "비밀번호 변경";
                              });
                              CustomSnackBar.showInfo(
                                context,
                                message: "비밀번호 변경 화면으로 이동합니다.",
                              );
                            },
                          ),
                          ActionSheetItem(
                            label: "계정 삭제",
                            icon: Icons.delete,
                            isDestructive: true,
                            onTap: () {
                              setState(() {
                                _lastAction = "계정 삭제";
                              });
                              CustomSnackBar.showError(
                                context,
                                message: "계정 삭제 기능은 구현되지 않았습니다.",
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  CustomButton(
                    btnText: "간단한 ActionSheet",
                    backgroundColor: Colors.purple.shade700,
                    onCallBack: () {
                      CustomActionSheet.showSimple(
                        context,
                        title: "색상 선택",
                        labels: ["빨강", "파랑", "초록", "노랑"],
                        callbacks: [
                          () {
                            setState(() {
                              _lastAction = "빨강 선택";
                            });
                            CustomSnackBar.show(
                              context,
                              message: "빨강을 선택했습니다.",
                              backgroundColor: Colors.red,
                            );
                          },
                          () {
                            setState(() {
                              _lastAction = "파랑 선택";
                            });
                            CustomSnackBar.show(
                              context,
                              message: "파랑을 선택했습니다.",
                              backgroundColor: Colors.blue,
                            );
                          },
                          () {
                            setState(() {
                              _lastAction = "초록 선택";
                            });
                            CustomSnackBar.show(
                              context,
                              message: "초록을 선택했습니다.",
                              backgroundColor: Colors.green,
                            );
                          },
                          () {
                            setState(() {
                              _lastAction = "노랑 선택";
                            });
                            CustomSnackBar.show(
                              context,
                              message: "노랑을 선택했습니다.",
                              backgroundColor: Colors.yellow.shade700,
                            );
                          },
                        ],
                      );
                    },
                  ),
                ],
              ),

              // 마지막 선택된 액션 표시
              CustomCard(
                padding: const EdgeInsets.all(16),
                child: CustomColumn(
                  spacing: 8,
                  children: [
                    CustomText(
                      "마지막 선택된 액션",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      _lastAction,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.purple, // 예제용 색상 유지
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
