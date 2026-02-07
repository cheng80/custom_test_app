import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// 슬라이더블 리스트 컨트롤러
//
// 슬라이더블 컨트롤러들을 관리하는 클래스입니다.
// 내부적으로 컨트롤러 생성, 동기화, 정리를 처리합니다.
class SlidableListController {
  final TickerProvider vsync;
  final String groupTag;
  final Map<int, SlidableController> _controllers = {};

  SlidableListController({
    required this.vsync,
    String? groupTag,
  }) : groupTag = groupTag ?? 'default_slidable_group';

  // 모든 슬라이더블 닫기
  Future<void> closeAll() async {
    await Future.wait(
      _controllers.values.map(
        (controller) =>
            controller.close(duration: const Duration(milliseconds: 200)),
      ),
    );
  }

  // 컨트롤러 동기화
  void syncControllers(List<int> ids) {
    final idSet = ids.toSet();

    // 삭제된 아이템의 컨트롤러 제거 및 정리
    final removedIds = _controllers.keys
        .where((id) => !idSet.contains(id))
        .toList();

    for (final id in removedIds) {
      _controllers.remove(id)?.dispose();
    }

    // 새로운 아이템의 컨트롤러 생성
    for (final id in idSet) {
      _controllers.putIfAbsent(
        id,
        () => SlidableController(vsync),
      );
    }
  }

  // 특정 ID의 컨트롤러 가져오기
  SlidableController? getController(int id) {
    return _controllers[id];
  }

  // 모든 컨트롤러 정리
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}

// 커스텀 슬라이더블 위젯
//
// 슬라이더블 액션을 쉽게 사용할 수 있도록 래핑한 위젯입니다.
// 내부적으로 컨트롤러 관리, groupTag 설정, 자동 닫기 등을 처리합니다.
// CustomSlidableList 내부에서 사용하면 자동으로 컨트롤러를 가져옵니다.
//
// 사용 예시:
// ```dart
// CustomSlidable(
//   id: todo.id!,
//   startActionPane: ActionPane(
//     motion: BehindMotion(),
//     children: [
//       SlidableAction(
//         onPressed: (context) async {
//           await CustomSlidableList.closeAll(context);
//           // 액션 처리
//         },
//         backgroundColor: Colors.blue,
//         icon: Icons.edit,
//         label: '수정',
//       ),
//     ],
//   ),
//   child: TodoCard(todo),
// )
// ```
class CustomSlidable extends StatelessWidget {
  // 아이템의 고유 ID (필수)
  final int id;

  // 슬라이더블 리스트 컨트롤러 (선택적, CustomSlidableList 내부에서는 자동으로 가져옴)
  final SlidableListController? controller;

  // 시작 액션 패널
  final ActionPane? startActionPane;

  // 끝 액션 패널
  final ActionPane? endActionPane;

  // 슬라이더블의 자식 위젯 (필수)
  final Widget child;

  // 슬라이더블 키
  final Key? keyValue;

  CustomSlidable({
    super.key,
    required this.id,
    this.controller,
    this.startActionPane,
    this.endActionPane,
    required this.child,
    this.keyValue,
  });

  @override
  Widget build(BuildContext context) {
    // 컨트롤러가 제공되지 않으면 InheritedWidget에서 가져오기
    final listController = controller ?? _SlidableListControllerProvider.of(context);
    
    if (listController == null) {
      // 컨트롤러가 없으면 일반 위젯 반환
      return child;
    }

    final slidableController = listController.getController(id);
    
    if (slidableController == null) {
      // 컨트롤러가 없으면 일반 위젯 반환
      return child;
    }

    return Slidable(
      key: keyValue ?? ValueKey<int>(id),
      controller: slidableController,
      groupTag: listController.groupTag,
      startActionPane: startActionPane,
      endActionPane: endActionPane,
      child: child,
    );
  }
}

// 커스텀 슬라이더블 리스트 위젯
//
// 슬라이더블이 적용된 리스트를 쉽게 만들 수 있도록 래핑한 위젯입니다.
// 내부적으로 SlidableAutoCloseBehavior와 컨트롤러 관리를 처리합니다.
//
// 사용 예시:
// ```dart
// CustomSlidableList<Todo>(
//   items: todos,
//   getId: (todo) => todo.id!,
//   itemBuilder: (context, todo, index) {
//     return CustomSlidable(
//       id: todo.id!,
//       startActionPane: ActionPane(
//         motion: BehindMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context) async {
//               await CustomSlidableList.closeAll(context);
//               // 액션 처리
//             },
//             backgroundColor: Colors.blue,
//             icon: Icons.edit,
//             label: '수정',
//           ),
//         ],
//       ),
//       child: TodoCard(todo),
//     );
//   },
//   vsync: this, // TickerProviderStateMixin 필요
// )
// ```
class CustomSlidableList<T> extends StatefulWidget {
  // 리스트 아이템들
  final List<T> items;

  // 아이템에서 ID를 추출하는 함수
  final int? Function(T) getId;

  // 아이템 빌더 (CustomSlidable을 반환해야 함)
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  // 리스트 위젯 (ListView, CustomListView 등)
  final Widget child;

  // 그룹 태그 (기본값: 'default_slidable_group')
  final String? groupTag;

  // TickerProvider (필수)
  final TickerProvider vsync;

  // 컨트롤러가 생성되었을 때 호출되는 콜백 (선택적)
  final void Function(SlidableListController)? onControllerCreated;

  CustomSlidableList({
    super.key,
    required this.items,
    required this.getId,
    required this.itemBuilder,
    required this.child,
    required this.vsync,
    this.groupTag,
    this.onControllerCreated,
  });

  // 모든 슬라이더블 닫기 (정적 메서드)
  static Future<void> closeAll(BuildContext context) async {
    final controller = _SlidableListControllerProvider.of(context);
    await controller?.closeAll();
  }

  @override
  State<CustomSlidableList<T>> createState() => _CustomSlidableListState<T>();
}

class _CustomSlidableListState<T> extends State<CustomSlidableList<T>> {
  late SlidableListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SlidableListController(
      vsync: widget.vsync,
      groupTag: widget.groupTag,
    );
    
    // 컨트롤러 생성 콜백 호출
    widget.onControllerCreated?.call(_controller);
    
    // 페이지 진입 시 열린 슬라이더블 닫기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.closeAll();
    });
  }

  @override
  void didUpdateWidget(CustomSlidableList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 아이템이 변경되면 컨트롤러 동기화
    if (widget.items != oldWidget.items) {
      final ids = widget.items
          .map(widget.getId)
          .whereType<int>()
          .toList();
      _controller.syncControllers(ids);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 아이템 ID 추출 및 컨트롤러 동기화
    final ids = widget.items
        .map(widget.getId)
        .whereType<int>()
        .toList();
    _controller.syncControllers(ids);

    return SlidableAutoCloseBehavior(
      child: _SlidableListControllerProvider(
        controller: _controller,
        child: widget.child,
      ),
    );
  }
}

// SlidableListController를 하위 위젯에 제공하는 위젯
class _SlidableListControllerProvider extends InheritedWidget {
  final SlidableListController controller;

  const _SlidableListControllerProvider({
    required this.controller,
    required super.child,
  });

  static SlidableListController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SlidableListControllerProvider>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(_SlidableListControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
