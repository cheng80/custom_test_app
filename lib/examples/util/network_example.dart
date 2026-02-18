import 'package:flutter/material.dart';

import '../../custom/external_util/network/custom_network_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// NetworkUtil 사용 예제 페이지
class NetworkExample extends StatefulWidget {
  const NetworkExample({super.key});

  @override
  State<NetworkExample> createState() => _NetworkExampleState();
}

class _NetworkExampleState extends State<NetworkExample> {
  String _result = '위 버튼을 눌러 예제를 실행하세요';

  void _updateResult(String result) => setState(() => _result = result);

  /// GET 요청 예제
  Future<void> _getExample() async {
    _updateResult('=== GET 요청 ===\n\n요청 중...');
    final response = await CustomNetworkUtil.get<Map<String, dynamic>>(
      'https://jsonplaceholder.typicode.com/posts/1',
    );
    _updateResult(
      response.success
          ? '=== GET 요청 ===\n\n✅ 성공!\n상태 코드: ${response.statusCode}\n'
                'ID: ${response.data?['id']}\n제목: ${response.data?['title']}'
          : '=== GET 요청 ===\n\n❌ 실패!\n에러: ${response.error}\n상태 코드: ${response.statusCode}',
    );
  }

  /// POST 요청 예제
  Future<void> _postExample() async {
    _updateResult('=== POST 요청 ===\n\n요청 중...');
    final response = await CustomNetworkUtil.post<Map<String, dynamic>>(
      'https://jsonplaceholder.typicode.com/posts',
      body: {'title': '테스트 제목', 'body': '테스트 내용', 'userId': 1},
    );
    _updateResult(
      response.success
          ? '=== POST 요청 ===\n\n✅ 성공!\n상태 코드: ${response.statusCode}\n'
                '생성된 ID: ${response.data?['id']}\n'
                '제목: ${response.data?['title']}\n내용: ${response.data?['body']}'
          : '=== POST 요청 ===\n\n❌ 실패!\n에러: ${response.error}',
    );
  }

  /// PUT 요청 예제
  Future<void> _putExample() async {
    _updateResult('=== PUT 요청 ===\n\n요청 중...');
    final response = await CustomNetworkUtil.put<Map<String, dynamic>>(
      'https://jsonplaceholder.typicode.com/posts/1',
      body: {'id': 1, 'title': '수정된 제목', 'body': '수정된 내용', 'userId': 1},
    );
    _updateResult(
      response.success
          ? '=== PUT 요청 ===\n\n✅ 성공!\n상태 코드: ${response.statusCode}\n'
                '제목: ${response.data?['title']}\n내용: ${response.data?['body']}'
          : '=== PUT 요청 ===\n\n❌ 실패!\n에러: ${response.error}',
    );
  }

  /// DELETE 요청 예제
  Future<void> _deleteExample() async {
    _updateResult('=== DELETE 요청 ===\n\n요청 중...');
    final response = await CustomNetworkUtil.delete(
      'https://jsonplaceholder.typicode.com/posts/1',
    );
    _updateResult(
      response.success
          ? '=== DELETE 요청 ===\n\n✅ 성공!\n상태 코드: ${response.statusCode}\n데이터가 삭제되었습니다.'
          : '=== DELETE 요청 ===\n\n❌ 실패!\n에러: ${response.error}',
    );
  }

  /// 쿼리 파라미터 예제
  Future<void> _queryParamsExample() async {
    _updateResult('=== 쿼리 파라미터 ===\n\n요청 중...');
    final response = await CustomNetworkUtil.get<List<dynamic>>(
      'https://jsonplaceholder.typicode.com/posts',
      queryParams: {'userId': '1', '_limit': '3'},
    );
    if (response.success) {
      final dataList = response.data;
      var text =
          '=== 쿼리 파라미터 ===\n\n✅ 성공!\n'
          '상태 코드: ${response.statusCode}\n'
          '받은 데이터: ${dataList is List ? dataList.length : 0}건\n';
      if (dataList is List && dataList.isNotEmpty) {
        for (var i = 0; i < dataList.length; i++) {
          text += '\n[${i + 1}] ${dataList[i]['title']}';
        }
      }
      _updateResult(text);
    } else {
      _updateResult('=== 쿼리 파라미터 ===\n\n❌ 실패!\n에러: ${response.error}');
    }
  }

  /// 에러 처리 예제
  Future<void> _errorHandlingExample() async {
    _updateResult('=== 에러 처리 ===\n\n잘못된 URL로 요청 중...');
    final response = await CustomNetworkUtil.get<Map<String, dynamic>>(
      'https://invalid-url-that-does-not-exist.com/api',
    );
    _updateResult(
      response.success
          ? '=== 에러 처리 ===\n\n✅ 성공!\n데이터: ${response.data}'
          : '=== 에러 처리 ===\n\n❌ 실패 (예상된 동작)\n'
                '에러: ${response.error}\n상태 코드: ${response.statusCode}\n\n'
                '→ 에러 처리가 정상적으로 작동합니다!',
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'NetworkUtil 예제',
        backgroundColor: Colors.indigo,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24,
          children: [
            CustomText('HTTP 통신 예제', fontSize: 24, fontWeight: FontWeight.bold),

            // HTTP 메서드 버튼들
            _buildSection('요청 타입', [
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: 'GET',
                      onCallBack: _getExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: 'POST',
                      backgroundColor: Colors.green,
                      onCallBack: _postExample,
                    ),
                  ),
                ],
              ),
              CustomRow(
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: 'PUT',
                      backgroundColor: Colors.orange,
                      onCallBack: _putExample,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      btnText: 'DELETE',
                      backgroundColor: Colors.red,
                      onCallBack: _deleteExample,
                    ),
                  ),
                ],
              ),
            ]),

            // 추가 예제
            _buildSection('추가 예제', [
              CustomButton(
                btnText: '쿼리 파라미터 예제',
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 48),
                onCallBack: _queryParamsExample,
              ),
              CustomButton(
                btnText: '에러 처리 예제',
                backgroundColor: Colors.grey,
                minimumSize: const Size(double.infinity, 48),
                onCallBack: _errorHandlingExample,
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
                      fontSize: 13,
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
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, fontSize: 18, fontWeight: FontWeight.bold),
        ...children,
      ],
    );
  }
}
