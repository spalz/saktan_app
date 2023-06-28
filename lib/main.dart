import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saktan_app/screens/about_health/about_health_screen.dart';
import 'package:saktan_app/screens/help/help_screen.dart';
import 'package:saktan_app/screens/news/news_list_screen.dart';
import 'package:saktan_app/screens/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const SaktanApp());
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
      print('isFirstTime: $isFirstTime');
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
      MaterialPageRoute(builder: (context) => const AboutHealthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saktan',
      debugShowCheckedModeBanner: false,
      theme: whiteTheme,
      home: _isFirstTime ? const OnBoardingPage() : const AboutHealthScreen(),
      initialRoute: "/",
      routes: {
        "/health": (final context) => const AboutHealthScreen(),
        "/help": (final context) => const HelpScreen(),
        "/news": (final context) => const NewsList(),
      },
    );
  }
}
