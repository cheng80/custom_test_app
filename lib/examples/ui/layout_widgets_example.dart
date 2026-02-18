import 'package:flutter/material.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// 레이아웃 위젯 사용 예제 페이지
class LayoutWidgetsExample extends StatefulWidget {
  const LayoutWidgetsExample({super.key});

  @override
  State<LayoutWidgetsExample> createState() => _LayoutWidgetsExampleState();
}

class _LayoutWidgetsExampleState extends State<LayoutWidgetsExample> {
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
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(title: "레이아웃 위젯 예시", backgroundColor: Colors.teal),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() => _progressValue = 0.0);
        },
        child: SingleChildScrollView(
          child: CustomPadding.all(
            16.0,
            child: CustomColumn(
              spacing: 24, // 표준 Spacing 적용
              children: [
                CustomText(
                  "레이아웃 위젯 종합 예시",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
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
                          subtitle: CustomText(
                            "A: Google에서 개발한 크로스 플랫폼 프레임워크입니다.",
                            fontSize: 14,
                            color: p.textSecondary,
                          ),
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(label: "기본 Chip"),
                        CustomChip(label: "삭제 가능", onDeleted: () {}),
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
                              if (selected)
                                _selectedChips.add(tag);
                              else
                                _selectedChips.remove(tag);
                            });
                          },
                          selectedColor: Colors.teal,
                          selectedLabelColor: Colors.white,
                        );
                      }).toList(),
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
                    CustomRow(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomProgressIndicator.circular(),
                        CustomProgressIndicator.circular(
                          size: 50,
                          color: Colors.teal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomProgressIndicator.linear(
                      value: _progressValue,
                      label: "${(_progressValue * 100).toInt()}%",
                      color: Colors.teal,
                    ),
                    CustomSlider(
                      value: _progressValue,
                      onChanged: (value) =>
                          setState(() => _progressValue = value),
                    ),
                    CustomButton(
                      btnText: "초기화",
                      minimumSize: const Size(double.infinity, 48),
                      onCallBack: () => setState(() => _progressValue = 0.0),
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
