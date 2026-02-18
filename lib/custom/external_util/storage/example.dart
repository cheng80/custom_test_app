import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'custom_storage_util.dart';
import '../../widgets.dart';
import '../../custom_theme_helper.dart';

// StorageUtil 사용 예제
//
// 이 파일은 CustomStorageUtil의 사용 예제를 보여줍니다.
// 실제 앱에서는 main() 함수에서 init()을 호출해야 합니다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // StorageUtil 초기화 (앱 시작 시 한 번만 호출)
  await CustomStorageUtil.init();

  runApp(const StorageExampleApp());
}

class StorageExampleApp extends StatelessWidget {
  const StorageExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StorageUtil 예제',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1976D2),
      ),
      home: const StorageExamplePage(),
    );
  }
}

class StorageExamplePage extends StatefulWidget {
  const StorageExamplePage({super.key});

  @override
  State<StorageExamplePage> createState() => _StorageExamplePageState();
}

class _StorageExamplePageState extends State<StorageExamplePage> {
  String? _username;
  int? _age;
  bool? _isDarkMode;
  List<String>? _tags;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 저장된 데이터 불러오기
  Future<void> _loadData() async {
    final username = await CustomStorageUtil.getString('username');
    final age = await CustomStorageUtil.getInt('age');
    final isDarkMode = await CustomStorageUtil.getBool('isDarkMode');
    final tags = await CustomStorageUtil.getStringList('tags');

    setState(() {
      _username = username;
      _age = age;
      _isDarkMode = isDarkMode;
      _tags = tags;
    });
  }

  // 기본 타입 저장 예제
  Future<void> _saveBasicTypes() async {
    await CustomStorageUtil.setString('username', '홍길동');
    await CustomStorageUtil.setInt('age', 25);
    await CustomStorageUtil.setBool('isDarkMode', true);
    await CustomStorageUtil.setDouble('price', 99.99);
    await CustomStorageUtil.setStringList('tags', [
      'flutter',
      'dart',
      'mobile',
    ]);

    await _loadData();
  }

  // 객체 저장 예제
  Future<void> _saveObject() async {
    final user = User(name: '홍길동', age: 25, email: 'hong@example.com');
    await CustomStorageUtil.setObject('user', user);

    // 객체 불러오기
    final savedUser = await CustomStorageUtil.getObject<User>(
      'user',
      (json) => User.fromJson(json),
    );

    if (savedUser != null) {
      debugPrint('저장된 사용자: ${savedUser.name}, ${savedUser.age}세');
    }
  }

  // 리스트 저장 예제
  Future<void> _saveList() async {
    final items = [
      Item(name: '사과', price: 1000),
      Item(name: '바나나', price: 2000),
      Item(name: '오렌지', price: 1500),
    ];

    await CustomStorageUtil.setList('items', items);

    // 리스트 불러오기
    final savedItems = await CustomStorageUtil.getList<Item>(
      'items',
      (json) => Item.fromJson(json),
    );

    if (savedItems != null) {
      debugPrint('저장된 아이템 개수: ${savedItems.length}');
    }
  }

  // 키 삭제 예제
  Future<void> _removeKey() async {
    await CustomStorageUtil.remove('username');
    await _loadData();
  }

  // 모든 데이터 삭제 예제
  Future<void> _clearAll() async {
    await CustomStorageUtil.clear();
    await _loadData();
  }

  // 키 존재 여부 확인 예제
  Future<void> _checkKey() async {
    final exists = await CustomStorageUtil.containsKey('username');
    debugPrint('username 키 존재 여부: $exists');
  }

  // 모든 키 가져오기 예제
  Future<void> _getAllKeys() async {
    final keys = await CustomStorageUtil.getAllKeys();
    debugPrint('모든 키: $keys');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomThemeHelper.background(context),
      appBar: CustomAppBar(title: "StorageUtil 예제"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomColumn(
          spacing: 12,
          children: [
            // 저장된 데이터 표시
            CustomCard(
              child: CustomPadding.all(
                16,
                child: CustomColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    CustomText(
                      '저장된 데이터',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText('이름: ${_username ?? '없음'}'),
                    CustomText('나이: ${_age ?? '없음'}'),
                    CustomText('다크모드: ${_isDarkMode ?? '없음'}'),
                    CustomText('태그: ${_tags?.join(', ') ?? '없음'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 기본 타입 저장 버튼
            CustomButton(onCallBack: _saveBasicTypes, btnText: '기본 타입 저장'),

            // 객체 저장 버튼
            CustomButton(onCallBack: _saveObject, btnText: '객체 저장'),

            // 리스트 저장 버튼
            CustomButton(onCallBack: _saveList, btnText: '리스트 저장'),

            // 키 삭제 버튼
            CustomButton(onCallBack: _removeKey, btnText: '키 삭제 (username)'),

            // 키 존재 여부 확인 버튼
            CustomButton(onCallBack: _checkKey, btnText: '키 존재 여부 확인'),

            // 모든 키 가져오기 버튼
            CustomButton(onCallBack: _getAllKeys, btnText: '모든 키 가져오기'),

            // 모든 데이터 삭제 버튼
            CustomButton(
              onCallBack: _clearAll,
              backgroundColor: const Color(0xFFD32F2F),
              btnText: '모든 데이터 삭제',
            ),
          ],
        ),
      ),
    );
  }
}

// 예제용 User 클래스
class User {
  final String name;
  final int age;
  final String email;

  User({required this.name, required this.age, required this.email});

  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'email': email};

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] as String,
    age: json['age'] as int,
    email: json['email'] as String,
  );
}

// 예제용 Item 클래스
class Item {
  final String name;
  final int price;

  Item({required this.name, required this.price});

  Map<String, dynamic> toJson() => {'name': name, 'price': price};

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(name: json['name'] as String, price: json['price'] as int);
}
