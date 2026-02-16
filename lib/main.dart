//main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme_colors.dart';
import 'theme/theme_provider.dart';

import 'pages/test_home.dart';

//import 'package:프로젝트명/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeMode: _themeMode,
      onToggleTheme: _toggleTheme,
      child: MaterialApp(
            title: 'Main',
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppThemeColors.lightBackground,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppThemeColors.darkBackground,
            ),
            themeMode: _themeMode,
      debugShowCheckedModeBanner: false, // 우측 상단 디버그 배너 제거
      // 다국어 지원
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 영어
        const Locale('ko', 'KR'), // 한국어
        const Locale('ja', 'JP'), // 일본어
      ],


      /*
      initialRoute: '/', // 처음 화면 지정
      routes: {
        '/': (context) => TestHome(onToggleTheme: _toggleTheme),
        '/util': (context) => const UtilPage(),
        '/storage': (context) => const StoragePage(),
        '/network': (context) => const NetworkPage(),
        '/textfield': (context) => const TextFieldPage(),
        '/listview': (context) => const ListViewPage(),
        '/dialog': (context) => const DialogPage(),
        '/tabbar': (context) => const TabBarPage(),
        '/snackbar': (context) => const SnackBarActionSheetPage(),
        '/layout': (context) => const LayoutWidgetsPage(),
        '/bottomsheet': (context) => const BottomSheetPage(),
        '/navigation': (context) => const NavigationWidgetsPage(),
      },
      */
      home: const TestHome(),
    ),
    );
  }
}
