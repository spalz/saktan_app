// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Handbook of Reproductive and Sexual Health`
  String get guideTitle {
    return Intl.message(
      'Handbook of Reproductive and Sexual Health',
      name: 'guideTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get onBoardingOneTtitlePart1 {
    return Intl.message(
      'Health',
      name: 'onBoardingOneTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: HIV, sexuality, rights`
  String get onBoardingOneTtitlePart2 {
    return Intl.message(
      ': HIV, sexuality, rights',
      name: 'onBoardingOneTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `Learn about the importance of health, including HIV infection, various aspects of sexuality and your rights in this area.`
  String get onBoardingOneDesc {
    return Intl.message(
      'Learn about the importance of health, including HIV infection, various aspects of sexuality and your rights in this area.',
      name: 'onBoardingOneDesc',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get onBoardingTwoTtitlePart1 {
    return Intl.message(
      'Help',
      name: 'onBoardingTwoTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: crisis centers, links`
  String get onBoardingTwoTtitlePart2 {
    return Intl.message(
      ': crisis centers, links',
      name: 'onBoardingTwoTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `If necessary, we are ready to provide you with assistance and support. Contact our crisis centers and find useful links.`
  String get onBoardingTwoDesc {
    return Intl.message(
      'If necessary, we are ready to provide you with assistance and support. Contact our crisis centers and find useful links.',
      name: 'onBoardingTwoDesc',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get onBoardingThreeTtitlePart1 {
    return Intl.message(
      'News',
      name: 'onBoardingThreeTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: events and not only`
  String get onBoardingThreeTtitlePart2 {
    return Intl.message(
      ': events and not only',
      name: 'onBoardingThreeTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `Refreshing news about reproductive and sexual health. Learn, upgrade and succeed in your life!`
  String get onBoardingThreeDesc {
    return Intl.message(
      'Refreshing news about reproductive and sexual health. Learn, upgrade and succeed in your life!',
      name: 'onBoardingThreeDesc',
      desc: '',
      args: [],
    );
  }

  /// `To begin`
  String get onBoardingButtonToBegin {
    return Intl.message(
      'To begin',
      name: 'onBoardingButtonToBegin',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get settingsAbout {
    return Intl.message(
      'About the app',
      name: 'settingsAbout',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get settingsAboutApp {
    return Intl.message(
      'About the app',
      name: 'settingsAboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get settingsPrivacyPolice {
    return Intl.message(
      'Privacy Policy',
      name: 'settingsPrivacyPolice',
      desc: '',
      args: [],
    );
  }

  /// `On health`
  String get navigationGuides {
    return Intl.message(
      'On health',
      name: 'navigationGuides',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get navigationHelp {
    return Intl.message(
      'Help',
      name: 'navigationHelp',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get navigationArticles {
    return Intl.message(
      'News',
      name: 'navigationArticles',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get helpCategoriesTitle {
    return Intl.message(
      'Contacts',
      name: 'helpCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Didn't find what you were looking for?`
  String get helpDidntFindTitle {
    return Intl.message(
      'Didn\'t find what you were looking for?',
      name: 'helpDidntFindTitle',
      desc: '',
      args: [],
    );
  }

  /// `Useful links`
  String get helpDidntFindUsefulllinks {
    return Intl.message(
      'Useful links',
      name: 'helpDidntFindUsefulllinks',
      desc: '',
      args: [],
    );
  }

  /// `Getting help`
  String get helpDidntFindHelp {
    return Intl.message(
      'Getting help',
      name: 'helpDidntFindHelp',
      desc: '',
      args: [],
    );
  }

  /// `Useful links`
  String get usefullLinksTitle {
    return Intl.message(
      'Useful links',
      name: 'usefullLinksTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLangTitle {
    return Intl.message(
      'Language',
      name: 'settingsLangTitle',
      desc: '',
      args: [],
    );
  }

  /// `Русский`
  String get settingsLangTitleRu {
    return Intl.message(
      'Русский',
      name: 'settingsLangTitleRu',
      desc: '',
      args: [],
    );
  }

  /// `Кыргызский`
  String get settingsLangTitleKy {
    return Intl.message(
      'Кыргызский',
      name: 'settingsLangTitleKy',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get titleLoading {
    return Intl.message(
      'Loading...',
      name: 'titleLoading',
      desc: '',
      args: [],
    );
  }

  /// `Helps with`
  String get contactItemModalLabelDescription {
    return Intl.message(
      'Helps with',
      name: 'contactItemModalLabelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get contactItemModalLabelAddress {
    return Intl.message(
      'Address',
      name: 'contactItemModalLabelAddress',
      desc: '',
      args: [],
    );
  }

  /// `Open the map`
  String get contactItemModalLabelOpenMap {
    return Intl.message(
      'Open the map',
      name: 'contactItemModalLabelOpenMap',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contactItemModalLabelContacts {
    return Intl.message(
      'Contacts',
      name: 'contactItemModalLabelContacts',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ky'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
