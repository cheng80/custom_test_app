import 'package:flutter/material.dart';
import '../../custom/util/collection/custom_collection_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// CollectionUtil 사용 예제 페이지
class CollectionExample extends StatefulWidget {
  const CollectionExample({super.key});

  @override
  State<CollectionExample> createState() => _CollectionExampleState();
}

class _CollectionExampleState extends State<CollectionExample> {
  String _result = '위 버튼을 눌러 예제를 실행하세요';

  void _updateResult(String result) => setState(() => _result = result);

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'CollectionUtil 예제',
        backgroundColor: Colors.blue,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24,
          children: [
            CustomText(
              'Collection 조작 예제',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildExampleButton('null-safe 체크', () {
                  final list = [1, 2, 3];
                  _updateResult(
                    'isEmpty(null): ${CustomCollectionUtil.isEmpty(null)}\nisNotEmpty([1,2,3]): ${CustomCollectionUtil.isNotEmpty(list)}',
                  );
                }),
                _buildExampleButton('중복 제거', () {
                  final numbers = [1, 2, 2, 3, 3, 3];
                  _updateResult(
                    '원본: $numbers\n제거: ${CustomCollectionUtil.unique(numbers)}',
                  );
                }),
                _buildExampleButton('그룹화', () {
                  final items = [
                    {'name': '사과', 'tag': '과일'},
                    {'name': '바나나', 'tag': '과일'},
                    {'name': '당근', 'tag': '채소'},
                  ];
                  final grouped = CustomCollectionUtil.groupBy(
                    items,
                    (i) => i['tag'],
                  );
                  _updateResult('그룹화 결과: $grouped');
                }),
                _buildExampleButton('청크나누기', () {
                  final list = [1, 2, 3, 4, 5];
                  _updateResult(
                    '원본: $list\n청크(2): ${CustomCollectionUtil.chunk(list, 2)}',
                  );
                }),
              ],
            ),
            Expanded(
              child: CustomCard(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: SelectableText(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
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

  Widget _buildExampleButton(String label, VoidCallback onPressed) {
    return CustomButton(
      btnText: label,
      onCallBack: onPressed,
      minimumSize: const Size(100, 40),
    );
  }
}
