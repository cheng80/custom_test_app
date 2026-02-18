import 'package:flutter/material.dart';
import '../../custom/util/xml/custom_xml_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// XmlUtil 사용 예제 페이지
class XmlUtilExample extends StatefulWidget {
  const XmlUtilExample({super.key});

  @override
  State<XmlUtilExample> createState() => _XmlUtilExampleState();
}

class _XmlUtilExampleState extends State<XmlUtilExample> {
  String _result = '버튼을 눌러 예제를 실행하세요';

  // 예제용 샘플 XML
  final String _sampleXml = '''<?xml version="1.0"?>
<company>
  <employee id="1" role="개발자">
    <name>홍길동</name>
    <age>25</age>
    <city>서울</city>
  </employee>
  <employee id="2" role="디자이너">
    <name>김영희</name>
    <age>30</age>
    <city>부산</city>
  </employee>
  <employee id="3" role="기획자">
    <name>이철수</name>
    <age>28</age>
    <city>대전</city>
  </employee>
</company>''';

  void _updateResult(String result) => setState(() => _result = result);

  /// 1. 안전한 파싱 + 검증
  void _safeParsingExample() {
    final validXml = '<root><item>테스트</item></root>';
    final invalidXml = '<root><잘못된 XML';

    final parsed1 = CustomXmlUtil.parse(validXml);
    final parsed2 = CustomXmlUtil.parse(invalidXml);
    final isValid1 = CustomXmlUtil.isValid(validXml);
    final isValid2 = CustomXmlUtil.isValid(invalidXml);

    _updateResult(
      '=== 안전한 파싱 & 검증 ===\n\n'
      '✅ 정상 XML:\n'
      '  입력: $validXml\n'
      '  isValid: $isValid1\n'
      '  파싱: ${parsed1 != null ? "성공" : "실패"}\n\n'
      '❌ 잘못된 XML:\n'
      '  입력: $invalidXml\n'
      '  isValid: $isValid2\n'
      '  파싱: ${parsed2 != null ? "성공" : "실패 (null 반환)"}\n\n'
      '→ 표준 xml 패키지는 예외 발생\n'
      '→ CustomXmlUtil은 null 반환 (크래시 방지)',
    );
  }

  /// 2. XML → Map 변환
  void _toMapExample() {
    final map = CustomXmlUtil.toMap(_sampleXml);

    _updateResult(
      '=== XML → Map 변환 (toMap) ===\n\n'
      '▶ 원본 XML:\n$_sampleXml\n\n'
      '▶ 변환된 Map:\n$map\n\n'
      '→ XML을 Dart Map으로 자동 변환\n'
      '→ 속성(id, role)도 함께 추출됨',
    );
  }

  /// 3. Map → XML 변환
  void _fromMapExample() {
    final map = {
      'name': '박지민',
      'age': '27',
      'skills': {
        'skill': ['Flutter', 'Dart', 'Firebase'],
      },
    };
    final xml = CustomXmlUtil.fromMap(map, rootTag: 'developer');
    final formatted = CustomXmlUtil.format(xml ?? '');

    _updateResult(
      '=== Map → XML 변환 (fromMap) ===\n\n'
      '▶ 원본 Map:\n$map\n\n'
      '▶ 변환된 XML:\n$formatted\n\n'
      '→ Dart Map을 XML 문자열로 자동 변환\n'
      '→ rootTag를 지정하여 루트 요소명 설정',
    );
  }

  /// 4. 태그 기반 텍스트 추출
  void _getTextExample() {
    final firstName = CustomXmlUtil.getText(_sampleXml, tag: 'name');
    final allNames = CustomXmlUtil.getTextList(_sampleXml, tag: 'name');
    final allCities = CustomXmlUtil.getTextList(_sampleXml, tag: 'city');

    _updateResult(
      '=== 태그 기반 텍스트 추출 ===\n\n'
      '▶ 원본 XML:\n$_sampleXml\n\n'
      '▶ getText(tag: "name"):\n'
      '  → $firstName (첫 번째만)\n\n'
      '▶ getTextList(tag: "name"):\n'
      '  → $allNames (모두 추출)\n\n'
      '▶ getTextList(tag: "city"):\n'
      '  → $allCities\n\n'
      '→ getText: 첫 번째 매칭만 반환\n'
      '→ getTextList: 모든 매칭을 리스트로 반환',
    );
  }

  /// 5. 속성 추출 (getAttribute)
  void _getAttributeExample() {
    final role1 = CustomXmlUtil.getAttribute(
      _sampleXml,
      tag: 'employee',
      attribute: 'role',
    );

    _updateResult(
      '=== 속성 추출 (getAttribute) ===\n\n'
      '▶ 원본 XML:\n$_sampleXml\n\n'
      '▶ getAttribute(tag: "employee", attribute: "role"):\n'
      '  → $role1\n\n'
      '→ XML 태그의 속성 값을 직접 추출\n'
      '→ <employee id="1" role="개발자"> 에서\n'
      '  role 속성값 "개발자"를 가져옴',
    );
  }

  /// 6. XML 엘리먼트 생성 (createElement)
  void _createElementExample() {
    final element = CustomXmlUtil.createElement(
      'product',
      text: null,
      attributes: {'id': '100', 'category': '전자제품'},
      children: {
        'name': '스마트폰',
        'price': '1200000',
        'specs': {'display': '6.7인치', 'battery': '5000mAh'},
      },
    );
    final formatted = CustomXmlUtil.format(element);

    _updateResult(
      '=== XML 엘리먼트 생성 (createElement) ===\n\n'
      '▶ 코드:\n'
      'createElement(\n'
      '  "product",\n'
      '  attributes: {id: "100", category: "전자제품"},\n'
      '  children: {name, price, specs...}\n'
      ')\n\n'
      '▶ 생성된 XML:\n$formatted\n\n'
      '→ 코드로 XML 구조를 직접 생성\n'
      '→ 속성, 텍스트, 중첩 자식 요소 지원',
    );
  }

  /// 7. 리스트 ↔ XML 변환
  void _listExample() {
    final list = [
      {'name': '사과', 'price': '3000'},
      {'name': '바나나', 'price': '2000'},
      {'name': '포도', 'price': '5000'},
    ];
    final xml = CustomXmlUtil.fromList(
      list,
      rootTag: 'fruits',
      itemTag: 'fruit',
    );
    final formatted = CustomXmlUtil.format(xml ?? '');

    // 다시 리스트로 변환
    final backToList = CustomXmlUtil.toList(xml ?? '', tag: 'fruit');

    _updateResult(
      '=== 리스트 ↔ XML 변환 ===\n\n'
      '▶ 원본 List:\n$list\n\n'
      '▶ fromList → XML:\n$formatted\n\n'
      '▶ toList → 다시 List:\n$backToList\n\n'
      '→ List<Map> ↔ XML 양방향 변환 지원',
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(title: 'XmlUtil 예제', backgroundColor: Colors.brown),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 16,
          children: [
            CustomText(
              'CustomXmlUtil 핵심 기능',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),

            _buildSection('기본 & 변환', [
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
                      btnText: 'XML→Map',
                      backgroundColor: Colors.teal,
                      onCallBack: _toMapExample,
                    ),
                  ),
                ],
              ),
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: 'Map→XML',
                      backgroundColor: Colors.indigo,
                      onCallBack: _fromMapExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: 'List↔XML',
                      backgroundColor: Colors.deepPurple,
                      onCallBack: _listExample,
                    ),
                  ),
                ],
              ),
            ]),

            _buildSection('추출 & 생성 (차별 기능)', [
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: '텍스트 추출',
                      backgroundColor: Colors.orange,
                      onCallBack: _getTextExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: '속성 추출',
                      backgroundColor: Colors.red,
                      onCallBack: _getAttributeExample,
                    ),
                  ),
                ],
              ),
              CustomButton(
                btnText: 'XML 엘리먼트 생성',
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
                onCallBack: _createElementExample,
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
                      fontSize: 11,
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
