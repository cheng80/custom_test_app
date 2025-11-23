/// 커스텀 유틸리티 라이브러리
///
/// 모든 커스텀 유틸리티를 export합니다.
/// 유틸리티만 필요한 경우 이 파일을 import하세요.
///
/// 사용 예시:
/// ```dart
/// import 'package:custom_test_app/custom/utils.dart';
///
/// CustomCommonUtil.formatDate(DateTime.now(), 'yyyy-MM-dd');
/// CustomCollectionUtil.unique([1, 2, 2, 3]);
/// ```
library;

// ============================================
// 공용 유틸리티
// ============================================

/// 공용 유틸리티 (날짜, 문자열, 검증, 포맷팅, 숫자 등)
export 'custom_common_util.dart';

// ============================================
// 추가 유틸리티 (의존성 순서로 export)
// ============================================

/// 컬렉션 유틸리티 (순수 Dart, 의존성 없음)
export 'util/collection/custom_collection_util.dart';

/// JSON 변환 유틸리티 (순수 Dart, 의존성 없음)
export 'util/json/custom_json_util.dart';

/// 타이머 유틸리티 (순수 Dart, 의존성 없음)
export 'util/timer/custom_timer_util.dart';

/// 스토리지 유틸리티 (shared_preferences 의존)
export 'util/storage/custom_storage_util.dart';

/// 네트워크 유틸리티 (http 패키지, CustomJsonUtil 의존)
export 'util/network/custom_network_util.dart';
