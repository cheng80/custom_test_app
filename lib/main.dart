//main.dart
import 'package:flutter/material.dart';

import 'home.dart';
import 'pages/dialog_page.dart';
import 'pages/list_view_page.dart';
import 'pages/snackbar_action_sheet_page.dart';
import 'pages/tab_bar_page.dart';
import 'pages/text_field_page.dart';
import 'pages/util_page.dart';

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
