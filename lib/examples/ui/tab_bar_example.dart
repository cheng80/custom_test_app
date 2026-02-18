import 'package:flutter/material.dart';

import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// TabBar & BottomNavBar 사용 예제 페이지
class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      items: [
        BottomNavItem(
          icon: Icons.home,
          selectedIcon: Icons.home,
          label: "홈",
          page: _buildHomePage(),
        ),
        BottomNavItem(
          icon: Icons.search,
          selectedIcon: Icons.search,
          label: "검색",
          page: _buildSearchPage(),
        ),
        BottomNavItem(
          icon: Icons.person,
          selectedIcon: Icons.person,
          label: "프로필",
          page: _buildProfilePage(),
        ),
      ],
      currentIndex: _currentBottomNavIndex,
      onTap: (index) => setState(() => _currentBottomNavIndex = index),
    );
  }

  /// 홈 페이지 (상단 탭바 예시)
  Widget _buildHomePage() {
    return Scaffold(
      appBar: CustomAppBar(title: "탭바 예시"),
      body: CustomTabBar(
        tabs: const ["동물", "과일"],
        children: [_buildAnimalTab(), _buildFruitTab()],
      ),
    );
  }

  /// 검색 페이지
  Widget _buildSearchPage() {
    final p = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(title: "검색"),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 20,
          children: [
            CustomText("검색 페이지", fontSize: 24, fontWeight: FontWeight.bold),
            CustomText(
              "여기에 검색 기능을 구현할 수 있습니다.",
              fontSize: 16,
              color: p.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  /// 프로필 페이지
  Widget _buildProfilePage() {
    return Scaffold(
      appBar: CustomAppBar(title: "프로필"),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 20,
          children: [
            CustomText("프로필 페이지", fontSize: 24, fontWeight: FontWeight.bold),
            const CustomCard(
              padding: EdgeInsets.all(16),
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text("사용자 님"),
                subtitle: Text("user@example.com"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalTab() {
    return SingleChildScrollView(
      child: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 12,
          children: [
            CustomText("동물 리스트", fontSize: 20, fontWeight: FontWeight.bold),
            _buildItemCard("벌", "images/bee.png"),
            _buildItemCard("고양이", "images/cat.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitTab() {
    return SingleChildScrollView(
      child: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 12,
          children: [
            CustomText("과일 리스트", fontSize: 20, fontWeight: FontWeight.bold),
            const CustomCard(
              padding: EdgeInsets.all(16),
              child: Text("사과, 바나나, 포도 등"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String name, String imagePath) {
    return CustomCard(
      padding: const EdgeInsets.all(12),
      child: CustomRow(
        spacing: 12,
        children: [
          CustomImage(imagePath, width: 60, height: 60, fit: BoxFit.cover),
          CustomText(name, fontSize: 18, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
