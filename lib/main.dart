//main.dart
import 'package:custom_test_app/home.dart';
import 'package:custom_test_app/pages/dialog_page.dart';
import 'package:custom_test_app/pages/list_view_page.dart';
import 'package:custom_test_app/pages/snackbar_action_sheet_page.dart';
import 'package:custom_test_app/pages/tab_bar_page.dart';
import 'package:custom_test_app/pages/text_field_page.dart';
import 'package:custom_test_app/pages/util_page.dart';
import 'package:flutter/material.dart';

//import 'package:프로젝트명/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false, // 우측 상단 디버그 배너 제거
      initialRoute: '/', // 처음 화면 지정
      routes: {
        '/': (context) => const Home(),
        '/util': (context) => const UtilPage(),
        '/textfield': (context) => const TextFieldPage(),
        '/listview': (context) => const ListViewPage(),
        '/dialog': (context) => const DialogPage(),
        '/tabbar': (context) => const TabBarPage(),
        '/snackbar': (context) => const SnackBarActionSheetPage(),
      },
    );
  }
}
