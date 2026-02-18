import 'package:flutter/material.dart';
import '../../custom/util/json/custom_json_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// JsonUtil 사용 예제 페이지
class JsonUtilExample extends StatefulWidget {
  const JsonUtilExample({super.key});

  @override
  State<JsonUtilExample> createState() => _JsonUtilExampleState();
}

class _JsonUtilExampleState extends State<JsonUtilExample> {
  String _result = '버튼을 눌러 예제를 실행하세요';

  // 예제용 샘플 데이터
  final Map<String, dynamic> _sampleData = {
    'user': {
      'name': '홍길동',
      'age': 25,
      'address': {'city': '서울', 'district': '강남구', 'zip': '06000'},
      'hobbies': ['독서', '운동', '코딩'],
    },
    'company': {'name': '테크코리아', 'department': '개발팀'},
  };

  String get _formattedSample =>
      CustomJsonUtil.format(CustomJsonUtil.encode(_sampleData) ?? '') ?? '';

  void _updateResult(String result) => setState(() => _result = result);

  /// 1. 안전한 파싱
  void _safeParsingExample() {
    final validJson = '{"name":"홍길동","age":25}';
    final invalidJson = '{잘못된 JSON 형식';

    final decoded1 = CustomJsonUtil.decode(validJson);
    final decoded2 = CustomJsonUtil.decode(invalidJson);
    final isValid1 = CustomJsonUtil.isValid(validJson);
    final isValid2 = CustomJsonUtil.isValid(invalidJson);

    _updateResult(
      '=== 안전한 파싱 ===\n\n'
      '✅ 정상 JSON:\n'
      '  입력: $validJson\n'
      '  isValid: $isValid1\n'
      '  결과: $decoded1\n\n'
      '❌ 잘못된 JSON:\n'
      '  입력: $invalidJson\n'
      '  isValid: $isValid2\n'
      '  결과: $decoded2 (크래시 없이 null)\n\n'
      '→ 표준 jsonDecode는 예외 발생\n'
      '→ CustomJsonUtil은 null 반환',
    );
  }

  /// 2. 경로 기반 값 접근
  void _getValueExample() {
    final city = CustomJsonUtil.getValue(_sampleData, 'user.address.city');
    final name = CustomJsonUtil.getValue(_sampleData, 'user.name');
    final dept = CustomJsonUtil.getValue(_sampleData, 'company.department');
    final none = CustomJsonUtil.getValue(_sampleData, 'user.phone');

    _updateResult(
      '=== 경로 기반 값 접근 (getValue) ===\n\n'
      '▶ 원본 데이터:\n$_formattedSample\n\n'
      '▶ 점(.) 표기법으로 중첩 값 접근:\n\n'
      'getValue("user.name")\n  → $name\n\n'
      'getValue("user.address.city")\n  → $city\n\n'
      'getValue("company.department")\n  → $dept\n\n'
      'getValue("user.phone")\n  → $none (없는 키 = null)',
    );
  }

  /// 3. 경로 기반 수정/삭제
  void _setRemoveExample() {
    final data =
        CustomJsonUtil.decode(CustomJsonUtil.encode(_sampleData)!)
            as Map<String, dynamic>;

    final before = CustomJsonUtil.format(CustomJsonUtil.encode(data)!);

    CustomJsonUtil.setValue(data, 'user.address.city', '부산');
    CustomJsonUtil.setValue(data, 'user.email', 'hong@test.com');
    CustomJsonUtil.removeValue(data, 'user.age');

    final after = CustomJsonUtil.format(CustomJsonUtil.encode(data)!);

    _updateResult(
      '=== 경로 기반 수정/삭제 ===\n\n'
      '▶ 변경 전:\n$before\n\n'
      '▶ 수행한 작업:\n'
      '  • setValue("user.address.city", "부산")\n'
      '  • setValue("user.email", "hong@test.com")\n'
      '  • removeValue("user.age")\n\n'
      '▶ 변경 후:\n$after',
    );
  }

  /// 4. JSON 병합
  void _mergeExample() {
    final json1 = {'name': '홍길동', 'age': 25, 'city': '서울'};
    final json2 = {'age': 30, 'email': 'hong@test.com', 'job': '개발자'};
    final merged = CustomJsonUtil.merge(json1, json2);

    _updateResult(
      '=== JSON 병합 (merge) ===\n\n'
      '▶ JSON 1:\n${CustomJsonUtil.format(CustomJsonUtil.encode(json1)!)}\n\n'
      '▶ JSON 2:\n${CustomJsonUtil.format(CustomJsonUtil.encode(json2)!)}\n\n'
      '▶ 병합 결과:\n${CustomJsonUtil.format(CustomJsonUtil.encode(merged)!)}\n\n'
      '→ 중복 키(age): 25 → 30 (json2 값 우선)\n'
      '→ 새 키(email, job): 추가됨',
    );
  }

  /// 5. 키 검색
  void _searchExample() {
    final results = CustomJsonUtil.searchKeys(
      _sampleData,
      'name',
      caseSensitive: false,
      exactMatch: true,
    );

    _updateResult(
      '=== 키 검색 (searchKeys) ===\n\n'
      '▶ 원본 데이터:\n$_formattedSample\n\n'
      '▶ 검색어: "name" (정확 매칭)\n\n'
      '검색 결과 (${results.length}건):\n'
      '${results.map((r) => '  • $r').join('\n')}\n\n'
      '→ 모든 중첩 레벨에서 검색\n'
      '→ user.name + company.name 발견',
    );
  }

  /// 6. 포맷팅 & 압축
  void _formatExample() {
    final compact = CustomJsonUtil.encode(_sampleData['user']);
    final formatted = CustomJsonUtil.format(compact ?? '');

    _updateResult(
      '=== 포맷팅 & 압축 ===\n\n'
      '▶ 원본 (압축 상태):\n$compact\n\n'
      '▶ format() 적용 (보기 좋게):\n$formatted\n\n'
      '▶ compress() 적용 (다시 한 줄):\n'
      '${CustomJsonUtil.compress(formatted ?? '')}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'JsonUtil 예제',
        backgroundColor: Colors.blueGrey,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 16,
          children: [
            CustomText(
              'CustomJsonUtil 핵심 기능',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),

            // 기본 기능
            _buildSection('기본 기능', [
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: '안전한 파싱',
                      onCallBack: _safeParsingExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: '포맷팅/압축',
                      backgroundColor: Colors.teal,
                      onCallBack: _formatExample,
                    ),
                  ),
                ],
              ),
            ]),

            // 경로 기반 조작
            _buildSection('경로 기반 조작 (차별 기능)', [
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: '값 접근',
                      backgroundColor: Colors.indigo,
                      onCallBack: _getValueExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: '수정/삭제',
                      backgroundColor: Colors.orange,
                      onCallBack: _setRemoveExample,
                    ),
                  ),
                ],
              ),
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: '병합',
                      backgroundColor: Colors.green,
                      onCallBack: _mergeExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: '키 검색',
                      backgroundColor: Colors.purple,
                      onCallBack: _searchExample,
                    ),
                  ),
                ],
              ),
            ]),

            // 결과 표시
            Expanded(
              child: CustomCard(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: SelectableText(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return CustomColumn(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, fontSize: 16, fontWeight: FontWeight.bold),
        ...children,
      ],
    );
  }
}
