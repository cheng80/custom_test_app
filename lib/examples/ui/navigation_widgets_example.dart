import 'package:flutter/material.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// 네비게이션 위젯 사용 예제 페이지
class NavigationWidgetsExample extends StatefulWidget {
  const NavigationWidgetsExample({super.key});

  @override
  State<NavigationWidgetsExample> createState() =>
      _NavigationWidgetsExampleState();
}

class _NavigationWidgetsExampleState extends State<NavigationWidgetsExample> {
  int _counter = 0;
  int _selectedDrawerIndex = 0;
  FloatingActionButtonType _currentFABType = FloatingActionButtonType.regular;

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: "네비게이션 위젯 예시",
        backgroundColor: Colors.indigo,
        // 드로워 아이콘을 명시적으로 설정하거나 기본값을 사용
        drawerIcon: Icons.menu,
      ),
      // Drawer는 예제로 유지하되 내비게이션은 Drawer 내부에서만 처리하도록 유도
      drawer: CustomDrawer(
        header: DrawerHeader(
          decoration: BoxDecoration(color: Colors.indigo),
          child: CustomColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 28, color: Colors.indigo),
              ),
              CustomText(
                "사용자 이름",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
        ),
        items: [
          DrawerItem(
            label: "프로필",
            icon: Icons.person,
            selected: _selectedDrawerIndex == 1,
            onTap: () {
              setState(() => _selectedDrawerIndex = 1);
              Navigator.pop(context); // 드로워만 닫기
              CustomSnackBar.show(context, message: "프로필 선택됨");
            },
          ),
          DrawerItem(
            label: "설정",
            icon: Icons.settings,
            selected: _selectedDrawerIndex == 2,
            onTap: () {
              setState(() => _selectedDrawerIndex = 2);
              Navigator.pop(context);
              CustomSnackBar.show(context, message: "설정 선택됨");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24, // 표준 Spacing 적용
            children: [
              CustomText(
                "네비게이션 위젯 종합 예시",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),

              // FAB 예시
              CustomColumn(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "CustomFloatingActionButton",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomCard(
                    padding: const EdgeInsets.all(16),
                    child: CustomColumn(
                      spacing: 12,
                      children: [
                        CustomText(
                          "FAB 타입 변경",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomRow(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: CustomButton(
                                btnText: "일반",
                                onCallBack: () => setState(
                                  () => _currentFABType =
                                      FloatingActionButtonType.regular,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                btnText: "작은",
                                onCallBack: () => setState(
                                  () => _currentFABType =
                                      FloatingActionButtonType.small,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                btnText: "확장",
                                onCallBack: () => setState(
                                  () => _currentFABType =
                                      FloatingActionButtonType.extended,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 카운터 표시
              CustomCard(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: CustomColumn(
                  spacing: 8,
                  children: [
                    CustomText(
                      "FAB 클릭 횟수",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      '$_counter',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    switch (_currentFABType) {
      case FloatingActionButtonType.regular:
        return CustomFloatingActionButton(
          onPressed: () => setState(() => _counter++),
          icon: Icons.add,
          backgroundColor: Colors.indigo,
        );
      case FloatingActionButtonType.small:
        return CustomFloatingActionButton.small(
          onPressed: () => setState(() => _counter++),
          icon: Icons.add,
          backgroundColor: Colors.blue,
        );
      case FloatingActionButtonType.extended:
        return CustomFloatingActionButton.extended(
          onPressed: () => setState(() => _counter++),
          label: "추가하기",
          icon: Icons.add,
          backgroundColor: Colors.purple,
        );
    }
  }
}
