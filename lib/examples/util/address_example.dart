import 'package:flutter/material.dart';
import '../../custom/util/address/custom_address_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// AddressUtil 사용 예제 페이지
class AddressExample extends StatefulWidget {
  const AddressExample({super.key});

  @override
  State<AddressExample> createState() => _AddressExampleState();
}

class _AddressExampleState extends State<AddressExample> {
  String _result = '위 버튼을 눌러 예제를 실행하세요';
  bool _isLoading = false;

  void _updateResult(String result) => setState(() => _result = result);

  Future<void> _fetchAddress() async {
    setState(() => _isLoading = true);
    try {
      final address = await CustomAddressUtil.getAddressFromCoordinates(
        37.497429,
        127.127782,
      );
      _updateResult(
        '=== 주소 가져오기 ===\n\n좌표: 37.497429, 127.127782\n주소: $address',
      );
    } catch (e) {
      _updateResult('❌ 오류 발생: $e');
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
        title: 'AddressUtil 예제',
        backgroundColor: Colors.blueAccent,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24,
          children: [
            CustomText(
              '위도/경도 주소 변환',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            CustomButton(
              btnText: _isLoading ? '로딩 중...' : '서울 가락동 주소 가져오기',
              minimumSize: const Size(double.infinity, 48),
              onCallBack: _isLoading ? () {} : _fetchAddress,
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
