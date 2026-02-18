import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../custom/util/json/custom_json_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// JSON API 파싱 예제 페이지
class JsonApiExample extends StatefulWidget {
  const JsonApiExample({super.key});

  @override
  State<JsonApiExample> createState() => _JsonApiExampleState();
}

class _JsonApiExampleState extends State<JsonApiExample> {
  String _result = '위 버튼을 눌러 API 데이터를 가져오세요';
  bool _isLoading = false;

  void _updateResult(String result) => setState(() => _result = result);

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse(
        'http://swopenapi.seoul.go.kr/api/subway/6f73517352636865353159466c7045/json/realtimeStationArrival/ALL/',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonString = utf8.decode(response.bodyBytes);
        final map = CustomJsonUtil.decode(jsonString);
        _updateResult(
          '✅ 데이터 수신 성공!\n\n${CustomJsonUtil.formatMap(map as Map<String, dynamic>)}',
        );
      } else {
        _updateResult('❌ 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      _updateResult('❌ 에러 발생: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'JSON API 예제',
        backgroundColor: Colors.blueAccent,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24,
          children: [
            CustomText(
              '서울시 지하철 실시간 정보 API',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            CustomButton(
              btnText: _isLoading ? '로딩 중...' : '실시간 정보 가져오기',
              minimumSize: const Size(double.infinity, 48),
              onCallBack: _isLoading ? () {} : _fetchData,
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
}
