import 'package:flutter/material.dart';

import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// ListView 사용 예제 페이지
class ListViewExample extends StatefulWidget {
  const ListViewExample({super.key});

  @override
  State<ListViewExample> createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<ListViewExample> {
  final List<Map<String, String>> _animalList = [
    {"name": "벌", "image": "images/bee.png", "description": "꽃가루를 모으는 곤충"},
    {"name": "고양이", "image": "images/cat.png", "description": "귀여운 반려동물"},
    {"name": "소", "image": "images/cow.png", "description": "우유를 주는 동물"},
    {"name": "강아지", "image": "images/dog.png", "description": "충실한 반려동물"},
    {"name": "여우", "image": "images/fox.png", "description": "영리한 동물"},
    {"name": "원숭이", "image": "images/monkey.png", "description": "똑똑한 동물"},
    {"name": "돼지", "image": "images/pig.png", "description": "귀여운 동물"},
    {"name": "늑대", "image": "images/wolf.png", "description": "야생의 동물"},
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "ListView 예시",
        backgroundColor: Colors.purple,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24, // 표준 Spacing 적용
          children: [
            CustomText(
              "동물 리스트",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            Expanded(
              child: CustomListView(
                itemCount: _animalList.length,
                itemSpacing: 12,
                itemBuilder: (context, index) {
                  final animal = _animalList[index];
                  return CustomCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.all(12),
                    child: CustomRow(
                      spacing: 16,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImage(
                            animal["image"]!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: CustomColumn(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                animal["name"]!,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                animal["description"]!,
                                fontSize: 14,
                                color: p.textSecondary,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: p.textSecondary,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
