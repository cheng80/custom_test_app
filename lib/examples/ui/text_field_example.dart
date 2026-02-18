import 'package:flutter/material.dart';

import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// TextField 사용 예제 페이지
class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _pwController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _pwController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: p.background,
        appBar: CustomAppBar(
          title: "TextField 예시",
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: CustomPadding.all(
            16.0,
            child: CustomColumn(
              spacing: 24, // 표준 Spacing 적용
              children: [
                CustomText(
                  "입력 필드 종합 예시",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),

                // 기본 텍스트 입력
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "기본 텍스트 입력",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _idController,
                      labelText: "아이디를 입력하세요",
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),

                // 필수 입력 필드
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "필수 입력 필드 (required: true)",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _nameController,
                      labelText: "이름 (필수)",
                      keyboardType: TextInputType.name,
                      required: true,
                      requiredMessage: "이름을 입력해주세요",
                    ),
                  ],
                ),

                // 비밀번호 입력
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "비밀번호 입력",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _pwController,
                      labelText: "비밀번호를 입력하세요",
                      obscureText: true,
                    ),
                  ],
                ),

                // 이메일 입력
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "이메일 입력 (필수)",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      labelText: "이메일",
                      keyboardType: TextInputType.emailAddress,
                      required: true,
                      requiredMessage: "이메일을 입력해주세요",
                    ),
                  ],
                ),

                // 전화번호 입력 (textCheck 예시)
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "전화번호 입력 (textCheck 사용 예시)",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      labelText: "전화번호",
                      keyboardType: TextInputType.phone,
                    ),
                    CustomButton(
                      btnText: "textCheck 검증",
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 48), // 너비 표준화
                      onCallBack: () {
                        FocusScope.of(context).unfocus();
                        // 위에서부터 순차적으로 빈 필드 체크
                        if (!CustomTextField.textCheck(
                          context,
                          _nameController,
                        )) {
                          CustomSnackBar.showError(
                            context,
                            message: "이름을 입력해주세요",
                          );
                          return;
                        }

                        if (!CustomTextField.textCheck(
                          context,
                          _emailController,
                        )) {
                          CustomSnackBar.showError(
                            context,
                            message: "이메일을 입력해주세요",
                          );
                          return;
                        }

                        if (!CustomTextField.textCheck(
                          context,
                          _phoneController,
                        )) {
                          CustomSnackBar.showError(
                            context,
                            message: "전화번호를 입력해주세요",
                          );
                          return;
                        }

                        CustomDialog.show(
                          context,
                          title: "검증 성공",
                          message: "이름, 이메일, 전화번호가 모두 입력되었습니다.",
                          type: DialogType.single,
                        );
                      },
                    ),
                  ],
                ),

                // 숫자 입력
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "숫자 입력",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextField(
                      controller: _numberController,
                      labelText: "숫자를 입력하세요",
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),

                // Form을 사용한 검증 예시
                CustomColumn(
                  spacing: 12,
                  children: [
                    CustomText(
                      "Form 검증 예시",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Form(
                      key: _formKey,
                      child: CustomColumn(
                        spacing: 12,
                        children: [
                          CustomTextField(
                            controller: _idController,
                            labelText: "아이디 (필수)",
                            required: true,
                            requiredMessage: "아이디를 입력해주세요",
                          ),
                          CustomTextField(
                            controller: _pwController,
                            labelText: "비밀번호 (필수)",
                            obscureText: true,
                            required: true,
                            requiredMessage: "비밀번호를 입력해주세요",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // 제출 버튼들 - 균등 배치
                CustomRow(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "입력값 확인",
                        backgroundColor: Colors.green,
                        onCallBack: () {
                          FocusScope.of(context).unfocus();
                          CustomDialog.show(
                            context,
                            title: "입력값 확인",
                            message:
                                "아이디: ${_idController.text}\n"
                                "이름: ${_nameController.text}\n"
                                "이메일: ${_emailController.text}\n"
                                "전화번호: ${_phoneController.text}\n"
                                "숫자: ${_numberController.text}",
                            type: DialogType.single,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        btnText: "Form 검증",
                        onCallBack: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            CustomDialog.show(
                              context,
                              title: "검증 성공",
                              message: "모든 필수 항목이 입력되었습니다.",
                              type: DialogType.single,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
