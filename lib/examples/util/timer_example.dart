import 'package:flutter/material.dart';
import '../../custom/util/timer/custom_timer_util.dart';
import '../../custom/widgets.dart';
import '../../theme/app_theme_colors.dart';

/// TimerUtil 사용 예제 페이지
class TimerExample extends StatefulWidget {
  const TimerExample({super.key});

  @override
  State<TimerExample> createState() => _TimerExampleState();
}

class _TimerExampleState extends State<TimerExample> {
  static const _delayedId = 'delayed_timer';
  static const _periodicId = 'periodic_timer';

  String _delayedResult = '대기 중';
  String _periodicResult = '대기 중';
  int _counter = 0;

  @override
  void dispose() {
    CustomTimerUtil.cancelAllById();
    super.dispose();
  }

  /// ID 기반 지연 실행 (3초)
  void _delayedWithId() {
    // 기존 동일 ID 타이머가 있으면 자동으로 취소 후 재등록
    CustomTimerUtil.cancelById(_delayedId);
    setState(() => _delayedResult = '3초 후 실행 예정...');
    CustomTimerUtil.createDelayedWithId(
      _delayedId,
      const Duration(seconds: 3),
      () {
        if (mounted) setState(() => _delayedResult = '3초 후 실행 완료!');
      },
    );
  }

  /// ID 기반 반복 실행 (1초 간격)
  void _periodicWithId() {
    CustomTimerUtil.cancelById(_periodicId);
    _counter = 0;
    setState(() => _periodicResult = '1초마다 카운트 시작...');
    CustomTimerUtil.createPeriodicWithId(
      _periodicId,
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _counter++;
          _periodicResult = '카운트 = $_counter';
        });
      },
    );
  }

  /// 반복 타이머만 ID로 중지
  void _cancelPeriodicOnly() {
    final cancelled = CustomTimerUtil.cancelById(_periodicId);
    setState(() {
      _periodicResult = cancelled ? '중지됨 (카운트: $_counter)' : '실행 중인 타이머 없음';
    });
  }

  /// 반복 타이머 일시정지
  void _pausePeriodic() {
    final paused = CustomTimerUtil.pauseById(_periodicId);
    setState(() {
      _periodicResult = paused ? '일시정지 (카운트: $_counter)' : '일시정지할 타이머 없음';
    });
  }

  /// 반복 타이머 재개
  void _resumePeriodic() {
    final resumed = CustomTimerUtil.resumeById(_periodicId);
    setState(() {
      _periodicResult = resumed ? '재개됨...' : '재개할 타이머 없음';
    });
  }

  /// 모든 ID 타이머 중지
  void _cancelAll() {
    CustomTimerUtil.cancelAllById();
    setState(() {
      _delayedResult = '전체 중지됨';
      _periodicResult = '전체 중지됨';
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.appTheme;
    return Scaffold(
      backgroundColor: p.background,
      appBar: CustomAppBar(
        title: 'TimerUtil 예제',
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: CustomPadding.all(
          16.0,
          child: CustomColumn(
            spacing: 24,
            children: [
              CustomText(
                '타이머 관리 예제',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

              // 타이머 시작 버튼
              _buildSection('타이머 시작', [
                CustomButton(btnText: '지연 실행 (3초)', onCallBack: _delayedWithId),
                CustomButton(
                  btnText: '반복 실행 (1초 간격)',
                  backgroundColor: Colors.blue,
                  onCallBack: _periodicWithId,
                ),
              ]),

              // 상태 표시 - 각각 별도 카드
              _buildSection('타이머 상태', [
                _buildStatusCard(
                  icon: Icons.timer,
                  label: '지연 실행 ($_delayedId)',
                  value: _delayedResult,
                  color: Colors.orange,
                ),
                _buildStatusCard(
                  icon: Icons.repeat,
                  label: '반복 실행 ($_periodicId)',
                  value: _periodicResult,
                  color: Colors.blue,
                ),
              ]),

              // ID 기반 개별 제어
              _buildSection('ID 기반 개별 제어 (반복 타이머)', [
                CustomButton(
                  btnText: '반복 타이머만 중지 (cancelById)',
                  backgroundColor: Colors.red,
                  onCallBack: _cancelPeriodicOnly,
                ),
                CustomRow(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: '일시정지',
                        backgroundColor: Colors.amber,
                        onCallBack: _pausePeriodic,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        btnText: '재개',
                        backgroundColor: Colors.green,
                        onCallBack: _resumePeriodic,
                      ),
                    ),
                  ],
                ),
              ]),

              // 전체 제어
              CustomButton(
                btnText: '모든 타이머 중지 (cancelAllById)',
                backgroundColor: Colors.red.shade700,
                minimumSize: const Size(double.infinity, 48),
                onCallBack: _cancelAll,
              ),
            ],
          ),
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

  Widget _buildStatusCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return CustomCard(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: CustomColumn(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(label, fontSize: 13, fontWeight: FontWeight.bold),
                CustomText(value, fontSize: 16, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
