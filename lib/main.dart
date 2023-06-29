import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saktan_app/generated/l10n.dart';
//
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/pages/help/help.dart';
// import 'package:saktan_app/pages/news/news.dart';
import 'package:saktan_app/pages/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const SaktanApp()));
}

class SaktanApp extends StatefulWidget {
  const SaktanApp({Key? key}) : super(key: key);

  @override
  _SaktanAppState createState() => _SaktanAppState();
}

class _SaktanAppState extends State<SaktanApp> {
  bool _isFirstTime = false;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    setState(() {
      // print('isFirstTime: $isFirstTime');
      _isFirstTime = isFirstTime;
    });

    if (!isFirstTime) {
      // Не первый раз открытия приложения
      navigateToAboutHealthScreen();
    }
  }

  Future<void> navigateToAboutHealthScreen() async {
    // Задержка для визуализации OnBoardingScreen перед переходом
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CategoriesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saktan',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: whiteTheme,
      home: _isFirstTime ? const OnBoardingPage() : const CategoriesPage(),
      initialRoute: "/",
      routes: {
        "/health": (final context) => const CategoriesPage(),
        "/help": (final context) => const HelpScreen(),
        // "/news": (final context) => const NewsList(),
      },
    );
  }
}
