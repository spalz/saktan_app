import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/pages/main_navigation_screen.dart';
import 'package:saktan_app/pages/on_boarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();

  // disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const SaktanApp()));
}

class SaktanApp extends StatefulWidget {
  const SaktanApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _SaktanAppState? state = context.findAncestorStateOfType<_SaktanAppState>();

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocale.languageCode);
    prefs.setString('countryCode', "");

    // ignore: invalid_use_of_protected_member
    state?.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  // ignore: library_private_types_in_public_api
  _SaktanAppState createState() => _SaktanAppState();
}

class _SaktanAppState extends State<SaktanApp> {
  bool _isFirstTime = false;
  Locale _locale = const Locale('ar', 'tn');

  @override
  void initState() {
    super.initState();
    _fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    checkFirstTime();
  }

  /*
  To get local from SharedPreferences if exists
   */
  Future<Locale> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    String languageCode = prefs.getString('languageCode') ?? 'ar';
    String countryCode = prefs.getString('countryCode') ?? 'tn';

    return Locale(languageCode, countryCode);
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (kDebugMode) {
      print("isFirstTime: $isFirstTime");
    }

    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saktan',
      locale: _locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
        Locale('ky', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: whiteTheme,
      home: _isFirstTime ? const OnBoardingPage() : const MainNavigationPage(),
      initialRoute: "/",
      routes: {
        "/guides": (final context) => const GuidesListPage(),
        "/help": (final context) => const ContactCategoriesPage(),
        "/articles": (final context) => const ArticlesListPage(),
      },
    );
  }
}
