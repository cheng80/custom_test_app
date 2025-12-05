import 'package:flutter/material.dart';
import '../custom/widgets.dart';
import '../theme/app_colors.dart';

/// 레이아웃 위젯 사용 예제 페이지
/// CustomExpansionTile, CustomChip, CustomProgressIndicator, CustomRefreshIndicator
class LayoutWidgetsPage extends StatefulWidget {
  const LayoutWidgetsPage({super.key});

  @override
  State<LayoutWidgetsPage> createState() => _LayoutWidgetsPageState();
}

class _LayoutWidgetsPageState extends State<LayoutWidgetsPage> {
  double _progressValue = 0.5;
  final List<String> _selectedChips = [];
  final List<String> _availableTags = [
    'Flutter',
    'Dart',
    'Widget',
    'UI',
    'Design',
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(title: "레이아웃 위젯 예시", backgroundColor: Colors.teal), // 예제용 색상 유지
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            _progressValue = 0.0;
          });
        },
        child: SingleChildScrollView(
          child: CustomPadding.all(
            16.0,
            child: CustomColumn(
              spacing: 24,
              children: [
                CustomText(
                  "레이아웃 위젯 종합 예시",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // 예제용 색상 유지
                ),

                // CustomExpansionTile 예시
                CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "CustomExpansionTile",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomExpansionTile(
                      title: CustomText(
                        "자주 묻는 질문",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      leading: Icon(Icons.help_outline, color: Colors.teal),
                      backgroundColor: Colors.teal.shade50,
                      borderRadius: 12,
                      children: [
                        ListTile(
                          title: CustomText("Q: Flutter란 무엇인가요?"),
                          subtitle:                         CustomText(
                            "A: Flutter는 Google에서 개발한 크로스 플랫폼 모바일 앱 개발 프레임워크입니다.",
                            fontSize: 14,
                            color: p.textSecondary,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: CustomText("Q: Dart 언어를 배워야 하나요?"),
                          subtitle: CustomText(
                            "A: 네, Flutter는 Dart 언어를 사용합니다. 하지만 배우기 쉬운 언어입니다.",
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    CustomExpansionTile(
                      title: CustomText(
                        "설정 메뉴",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      leading: Icon(Icons.settings, color: Colors.blue),
                      initiallyExpanded: false,
                      backgroundColor: Colors.blue.shade50,
                      borderRadius: 12,
                      children: [
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: CustomText("알림 설정"),
                          onTap: () => print("알림 설정"),
                        ),
                        ListTile(
                          leading: Icon(Icons.language),
                          title: CustomText("언어 설정"),
                          onTap: () => print("언어 설정"),
                        ),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: CustomText("다크 모드"),
                          onTap: () => print("다크 모드"),
                        ),
                      ],
                    ),
                  ],
                ),

                // CustomChip 예시
                CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "CustomChip",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "기본 Chip",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.textSecondary,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(label: "Flutter"),
                        CustomChip(label: "Dart"),
                        CustomChip(
                          label: "삭제 가능",
                          onDeleted: () => print("삭제됨"),
                        ),
                        CustomChip(
                          label: "아바타",
                          avatar: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      "선택 가능한 Chip (필터)",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.textSecondary,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableTags.map((tag) {
                        final isSelected = _selectedChips.contains(tag);
                        return CustomChip(
                          label: tag,
                          selectable: true,
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedChips.add(tag);
                              } else {
                                _selectedChips.remove(tag);
                              }
                            });
                          },
                          selectedColor: Colors.teal,
                          selectedLabelColor: Colors.white,
                        );
                      }).toList(),
                    ),
                    if (_selectedChips.isNotEmpty)
                      CustomText(
                        "선택된 태그: ${_selectedChips.join(', ')}",
                        fontSize: 14,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    const SizedBox(height: 8),
                    CustomText(
                      "고정 크기 Chip",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.textSecondary,
                    ),
                    CustomText(
                      "width 파라미터로 크기를 고정할 수 있습니다.",
                      fontSize: 12,
                      color: p.textSecondary,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(
                          label: "짧은",
                          width: 80,
                        ),
                        CustomChip(
                          label: "고정 크기",
                          width: 120,
                        ),
                        CustomChip(
                          label: "매우 긴 텍스트를 넣어도",
                          width: 120,
                        ),
                        CustomChip(
                          label: "삭제",
                          width: 100,
                          onDeleted: () => print("삭제됨"),
                        ),
                        CustomChip(
                          label: "선택",
                          width: 90,
                          selectable: true,
                          selected: false,
                          onSelected: (selected) => print("선택: $selected"),
                          selectedColor: Colors.teal,
                          selectedLabelColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),

                // CustomProgressIndicator 예시
                CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "CustomProgressIndicator",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "원형 로딩 인디케이터",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.textSecondary,
                    ),
                    CustomRow(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomProgressIndicator.circular(),
                        CustomProgressIndicator.circular(
                          size: 50,
                          color: Colors.teal,
                        ),
                        CustomProgressIndicator.circular(
                          size: 60,
                          color: Colors.blue,
                          strokeWidth: 6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      "선형 진행률 인디케이터",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.textSecondary,
                    ),
                    CustomProgressIndicator.linear(
                      value: _progressValue,
                      label: "${(_progressValue * 100).toInt()}%",
                      color: Colors.teal,
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 8),
                    CustomSlider(
                      value: _progressValue,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      title: "진행률 조절",
                      showValue: true,
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        setState(() {
                          _progressValue = value;
                        });
                      },
                    ),
                    CustomButton(
                      btnText: "진행률 초기화",
                      backgroundColor: Colors.teal,
                      onCallBack: () {
                        setState(() {
                          _progressValue = 0.0;
                        });
                      },
                    ),
                  ],
                ),

                // CustomRefreshIndicator 예시
                CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "CustomRefreshIndicator",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "위로 당겨서 새로고침 기능이 이미 적용되어 있습니다!",
                      fontSize: 14,
                      color: p.textSecondary,
                    ),
                    CustomCard(
                      padding: const EdgeInsets.all(16),
                      child: CustomColumn(
                        spacing: 8,
                        children: [
                          CustomText(
                            "Pull to Refresh",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            "화면을 위로 당기면 새로고침됩니다.",
                            fontSize: 14,
                            color: p.textSecondary,
                          ),
                          CustomText(
                            "이 페이지 전체가 RefreshIndicator로 감싸져 있습니다.",
                            fontSize: 12,
                            color: p.textSecondary,
                          ),
                        ],
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
