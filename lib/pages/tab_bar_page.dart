import 'package:flutter/material.dart';

import '../custom/widgets.dart';

/// TabBar & BottomNavBar 사용 예제 페이지
class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      items: [
        // 아이콘 + 텍스트 (기본)
        BottomNavItem(
          icon: Icons.home,
          selectedIcon: Icons.home,
          label: "홈",
          page: _buildHomePage(),
        ),
        // 아이콘 + 텍스트
        BottomNavItem(
          icon: Icons.search,
          selectedIcon: Icons.search,
          label: "검색",
          page: _buildSearchPage(),
        ),
        // 아이콘만 (텍스트 없음)
        BottomNavItem(
          icon: Icons.favorite_border,
          selectedIcon: Icons.favorite,
          page: _buildFavoritePage(),
        ),
        // 텍스트만 (아이콘 없음) - 개별 색상 지정 가능
        BottomNavItem(
          label: "프로필",
          page: _buildProfilePage(),
          selectedColor: Colors.purple,
          unselectedColor: Colors.grey.shade700, // 어두운 색상으로 설정하여 흰색 배경에서도 보이도록
        ),
      ],
      currentIndex: _currentBottomNavIndex,
      onTap: (index) {
        setState(() {
          _currentBottomNavIndex = index;
        });
      },
      selectedColor: Colors.blue,
      unselectedColor: Colors.grey,
    );
  }

  /// 홈 페이지 (상단 탭바 예시)
  Widget _buildHomePage() {
    return Scaffold(
      appBar: CustomAppBar(title: "홈", backgroundColor: Colors.blue),
      body: CustomTabBar(
        tabs: const ["동물", "과일", "꽃"],
        tabColor: Colors.blue,
        children: [_buildAnimalTab(), _buildFruitTab(), _buildFlowerTab()],
        onTap: (index) {
          // 탭 변경 이벤트 처리 예시
          final tabNames = ["동물", "과일", "꽃"];
          print("${tabNames[index]} 탭 선택됨");
          // 필요 시 상태 업데이트 또는 다른 로직 처리 가능
        },
      ),
    );
  }

  /// 검색 페이지
  Widget _buildSearchPage() {
    return Scaffold(
      appBar: CustomAppBar(title: "검색", backgroundColor: Colors.green),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 20,
          children: [
            CustomText(
              "검색 페이지",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            CustomText(
              "여기에 검색 기능을 구현할 수 있습니다.",
              fontSize: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// 좋아요 페이지
  Widget _buildFavoritePage() {
    return Scaffold(
      appBar: CustomAppBar(title: "좋아요", backgroundColor: Colors.red),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 20,
          children: [
            CustomText(
              "좋아요 페이지",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            CustomText("좋아요한 항목들을 표시합니다.", fontSize: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// 프로필 페이지
  Widget _buildProfilePage() {
    return Scaffold(
      appBar: CustomAppBar(title: "프로필", backgroundColor: Colors.purple),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 20,
          children: [
            CustomText(
              "프로필 페이지",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            CustomText("사용자 프로필 정보를 표시합니다.", fontSize: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// 동물 탭 내용
  Widget _buildAnimalTab() {
    final animals = [
      {"name": "벌", "image": "images/bee.png"},
      {"name": "고양이", "image": "images/cat.png"},
      {"name": "소", "image": "images/cow.png"},
      {"name": "강아지", "image": "images/dog.png"},
    ];

    return CustomPadding.all(
      16.0,
      child: CustomColumn(
        spacing: 12,
        children: [
          CustomText("동물", fontSize: 20, fontWeight: FontWeight.bold),
          ...animals.map((animal) {
            return CustomCard(
              padding: const EdgeInsets.all(12),
              child: CustomRow(
                spacing: 12,
                children: [
                  CustomImage(
                    animal["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  CustomText(
                    animal["name"]!,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 과일 탭 내용
  Widget _buildFruitTab() {
    return CustomPadding.all(
      16.0,
      child: CustomColumn(
        spacing: 12,
        children: [
          CustomText("과일", fontSize: 20, fontWeight: FontWeight.bold),
          CustomCard(
            padding: const EdgeInsets.all(16),
            child: CustomText("사과, 바나나, 포도 등", fontSize: 16),
          ),
          CustomCard(
            padding: const EdgeInsets.all(16),
            child: CustomText("오렌지, 파인애플, 수박 등", fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// 꽃 탭 내용
  Widget _buildFlowerTab() {
    return CustomPadding.all(
      16.0,
      child: CustomColumn(
        spacing: 12,
        children: [
          CustomText("꽃", fontSize: 20, fontWeight: FontWeight.bold),
          CustomCard(
            padding: const EdgeInsets.all(16),
            child: CustomText("장미, 튤립, 해바라기 등", fontSize: 16),
          ),
          CustomCard(
            padding: const EdgeInsets.all(16),
            child: CustomText("벚꽃, 코스모스, 수국 등", fontSize: 16),
          ),
        ],
      ),
    );
  }
}
