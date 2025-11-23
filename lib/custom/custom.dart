/// 커스텀 위젯 및 유틸리티 라이브러리
///
/// 모든 커스텀 위젯과 유틸리티를 export합니다.
/// GetX처럼 하나의 import로 모든 기능을 사용할 수 있습니다.
///
/// 사용 예시:
/// ```dart
/// import 'package:custom_test_app/custom/custom.dart';
///
/// // 위젯 사용
/// CustomText("안녕하세요")
/// CustomButton(btnText: "확인", onCallBack: () {})
///
/// // 유틸리티 사용
/// CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
/// CustomCollectionUtil.unique([1, 2, 2, 3]);
/// ```
///
/// 선택적 import:
/// - 위젯만 필요한 경우: `import 'package:custom_test_app/custom/widgets.dart';`
/// - 유틸리티만 필요한 경우: `import 'package:custom_test_app/custom/utils.dart';`
library;

// 위젯 export
export 'widgets.dart';

// 유틸리티 export
export 'utils.dart';
