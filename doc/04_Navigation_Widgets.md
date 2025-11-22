# 네비게이션 위젯 클래스

## CustomAppBar

AppBar를 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomAppBar(title: "홈")
```

### 주요 속성

| 속성                        | 타입            | 기본값           | 설명                             |
| --------------------------- | --------------- | ---------------- | -------------------------------- |
| `title`                     | `dynamic`       | 필수             | AppBar 제목 (String 또는 Widget) |
| `backgroundColor`           | `Color?`        | `Colors.blue`    | AppBar 배경색                    |
| `foregroundColor`           | `Color?`        | `Colors.white`   | AppBar 전경색/아이콘 색상        |
| `centerTitle`               | `bool`          | `true`           | 제목 중앙 정렬 여부              |
| `leading`                   | `Widget?`       | `null`           | 왼쪽에 표시할 위젯               |
| `actions`                   | `List<Widget>?` | `null`           | 오른쪽에 표시할 액션 버튼들      |
| `toolbarHeight`             | `double?`       | `kToolbarHeight` | AppBar 높이                      |
| `titleTextStyle`            | `TextStyle?`    | `null`           | 제목 텍스트 스타일               |
| `automaticallyImplyLeading` | `bool`          | `true`           | 자동으로 뒤로가기 버튼 표시 여부 |

### 사용 예시

```dart
// 기본 사용 (String)
CustomAppBar(title: "홈")

// 색상 지정
CustomAppBar(
  title: "홈",
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
)

// Widget 사용
CustomAppBar(
  title: Row(
    children: [
      Icon(Icons.home),
      SizedBox(width: 8),
      Text("홈"),
    ],
  ),
  backgroundColor: Colors.blue,
)

// 액션 버튼 추가
CustomAppBar(
  title: "홈",
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ],
)
```

---

## CustomBottomNavBar

하단 네비게이션 바를 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomBottomNavBar(
  items: [
    BottomNavItem(icon: Icons.home, label: "홈", page: HomePage()),
    BottomNavItem(icon: Icons.search, label: "검색", page: SearchPage()),
  ],
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
)
```

### 주요 속성

| 속성                 | 타입                      | 기본값        | 설명                                     |
| -------------------- | ------------------------- | ------------- | ---------------------------------------- |
| `items`              | `List<BottomNavItem>`     | 필수          | 하단 네비게이션 바 아이템 리스트 (2-5개) |
| `currentIndex`       | `int`                     | 필수          | 현재 선택된 인덱스                       |
| `onTap`              | `ValueChanged<int>`       | 필수          | 탭 선택 시 호출되는 콜백                 |
| `selectedColor`      | `Color?`                  | `Colors.blue` | 선택된 아이템 색상                       |
| `unselectedColor`    | `Color?`                  | `Colors.grey` | 선택되지 않은 아이템 색상                |
| `backgroundColor`    | `Color?`                  | `null`        | 배경색                                   |
| `type`               | `BottomNavigationBarType` | `fixed`       | 아이템 타입                              |
| `iconSize`           | `double?`                 | `24`          | 아이콘 크기                              |
| `selectedFontSize`   | `double?`                 | `14`          | 선택된 아이템 폰트 크기                  |
| `unselectedFontSize` | `double?`                 | `12`          | 선택되지 않은 아이템 폰트 크기           |

### BottomNavItem 속성

| 속성              | 타입        | 기본값 | 설명                                                   |
| ----------------- | ----------- | ------ | ------------------------------------------------------ |
| `icon`            | `IconData?` | `null` | 아이콘 (icon과 label 중 하나는 필수)                   |
| `selectedIcon`    | `IconData?` | `null` | 선택된 아이콘                                          |
| `label`           | `dynamic`   | `null` | 라벨 (String 또는 Widget, icon과 label 중 하나는 필수) |
| `page`            | `Widget`    | 필수   | 페이지 위젯                                            |
| `selectedColor`   | `Color?`    | `null` | 이 아이템의 선택된 색상                                |
| `unselectedColor` | `Color?`    | `null` | 이 아이템의 선택되지 않은 색상                         |

### 사용 예시

```dart
// 아이콘 + 텍스트
BottomNavItem(
  icon: Icons.home,
  label: "홈",
  page: HomePage(),
)

// 아이콘만
BottomNavItem(
  icon: Icons.favorite,
  selectedIcon: Icons.favorite,
  page: FavoritePage(),
)

// 텍스트만 (String)
BottomNavItem(
  label: "프로필",
  page: ProfilePage(),
)

// 텍스트만 (Widget) - 개별 색상 지정
BottomNavItem(
  label: CustomText("프로필", fontSize: 14, color: Colors.purple),
  page: ProfilePage(),
  selectedColor: Colors.purple,
  unselectedColor: Colors.grey.shade700,
)

// 전체 사용 예시
CustomBottomNavBar(
  items: [
    BottomNavItem(icon: Icons.home, label: "홈", page: _buildHomePage()),
    BottomNavItem(icon: Icons.search, label: "검색", page: _buildSearchPage()),
    BottomNavItem(icon: Icons.favorite, page: _buildFavoritePage()),
    BottomNavItem(
      label: "프로필",
      page: _buildProfilePage(),
      selectedColor: Colors.purple,
      unselectedColor: Colors.grey.shade700,
    ),
  ],
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  selectedColor: Colors.blue,
  unselectedColor: Colors.grey,
)
```

---

## CustomTabBar

상단 또는 하단에 탭바를 표시하는 커스텀 위젯입니다.

### 기본 사용법

```dart
CustomTabBar(
  tabs: ["탭1", "탭2", "탭3"],
  children: [
    Tab1Content(),
    Tab2Content(),
    Tab3Content(),
  ],
)
```

### 주요 속성

| 속성                   | 타입             | 기본값               | 설명                                            |
| ---------------------- | ---------------- | -------------------- | ----------------------------------------------- |
| `tabs`                 | `List<String>`   | 필수                 | 탭 라벨 리스트                                  |
| `children`             | `List<Widget>`   | 필수                 | 각 탭에 해당하는 위젯 리스트 (tabs와 개수 동일) |
| `tabColor`             | `Color?`         | `Colors.blue`        | 탭 색상                                         |
| `unselectedTabColor`   | `Color?`         | `Colors.grey`        | 선택되지 않은 탭 색상                           |
| `indicatorColor`       | `Color?`         | `tabColor`           | 탭 인디케이터 색상                              |
| `indicatorHeight`      | `double?`        | `3`                  | 탭 인디케이터 높이                              |
| `labelStyle`           | `TextStyle?`     | `null`               | 탭 라벨 스타일                                  |
| `unselectedLabelStyle` | `TextStyle?`     | `null`               | 선택되지 않은 탭 라벨 스타일                    |
| `isScrollable`         | `bool`           | `false`              | 탭이 스크롤 가능한지 여부                       |
| `position`             | `TabBarPosition` | `TabBarPosition.top` | 탭 위치 (top, bottom)                           |

### TabBarPosition

- `TabBarPosition.top`: 상단에 탭바 표시
- `TabBarPosition.bottom`: 하단에 탭바 표시

### 사용 예시

```dart
// 기본 사용
CustomTabBar(
  tabs: ["동물", "과일", "꽃"],
  children: [
    AnimalTab(),
    FruitTab(),
    FlowerTab(),
  ],
)

// 색상 지정
CustomTabBar(
  tabs: ["탭1", "탭2"],
  tabColor: Colors.purple,
  unselectedTabColor: Colors.grey.shade600,
  indicatorColor: Colors.purple,
  children: [
    Tab1Content(),
    Tab2Content(),
  ],
)

// 하단 탭바
CustomTabBar(
  tabs: ["홈", "검색", "프로필"],
  position: TabBarPosition.bottom,
  children: [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ],
)

// 스크롤 가능한 탭바
CustomTabBar(
  tabs: ["탭1", "탭2", "탭3", "탭4", "탭5"],
  isScrollable: true,
  children: [
    Tab1Content(),
    Tab2Content(),
    Tab3Content(),
    Tab4Content(),
    Tab5Content(),
  ],
)
```
