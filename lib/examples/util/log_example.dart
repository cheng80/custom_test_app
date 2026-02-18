import 'package:flutter/material.dart';
import '../../custom/util/log/custom_log_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// AppLogger 사용 예제 페이지
class LogExample extends StatefulWidget {
  const LogExample({super.key});

  @override
  State<LogExample> createState() => _LogExampleState();
}

class _LogExampleState extends State<LogExample> {
  final List<String> _logHistory = [];

  void _addLog(String message) {
    setState(() {
      _logHistory.add(
        '${DateTime.now().toString().substring(11, 19)} - $message',
      );
      if (_logHistory.length > 20) _logHistory.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'AppLogger 예제',
        backgroundColor: Colors.blueGrey,
      ),
      body: CustomPadding.all(
        16.0,
        child: CustomColumn(
          spacing: 24,
          children: [
            CustomText('로깅 유틸리티 예제', fontSize: 24, fontWeight: FontWeight.bold),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CustomButton(
                  btnText: '디버그 로그',
                  onCallBack: () {
                    AppLogger.d('디버그 메시지입니다');
                    _addLog('Debug 로그 (콘솔 확인)');
                  },
                ),
                CustomButton(
                  btnText: '정보 로그',
                  backgroundColor: Colors.blue,
                  onCallBack: () {
                    AppLogger.i('정보 메시지입니다');
                    _addLog('Info 로그 (콘솔 확인)');
                  },
                ),
                CustomButton(
                  btnText: '성공 로그',
                  backgroundColor: Colors.green,
                  onCallBack: () {
                    AppLogger.s('성공 메시지입니다');
                    _addLog('Success 로그 (콘솔 확인)');
                  },
                ),
                CustomButton(
                  btnText: '에러 로그',
                  backgroundColor: Colors.red,
                  onCallBack: () {
                    AppLogger.e('에러 메시지입니다');
                    _addLog('Error 로그 (콘솔 확인)');
                  },
                ),
              ],
            ),
            Expanded(
              child: CustomCard(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: CustomColumn(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      '로그 히스토리',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _logHistory.length,
                        itemBuilder: (context, index) => CustomText(
                          _logHistory[index],
                          fontSize: 12,
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
