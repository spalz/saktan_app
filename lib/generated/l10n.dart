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

  /// `Справочник по репродуктивному и сексуальному здоровью EN`
  String get guideTitle {
    return Intl.message(
      'Справочник по репродуктивному и сексуальному здоровью EN',
      name: 'guideTitle',
      desc: '',
      args: [],
    );
  }

  /// `Настройки en`
  String get settingsTitle {
    return Intl.message(
      'Настройки en',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Здоровье`
  String get onBoardingOneTtitlePart1 {
    return Intl.message(
      'Здоровье',
      name: 'onBoardingOneTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: ВИЧ, сексуальность, права`
  String get onBoardingOneTtitlePart2 {
    return Intl.message(
      ': ВИЧ, сексуальность, права',
      name: 'onBoardingOneTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `Узнайте о важности здоровья, включая ВИЧ-инфекцию, различные аспекты сексуальности и ваши права в этой сфере.`
  String get onBoardingOneDesc {
    return Intl.message(
      'Узнайте о важности здоровья, включая ВИЧ-инфекцию, различные аспекты сексуальности и ваши права в этой сфере.',
      name: 'onBoardingOneDesc',
      desc: '',
      args: [],
    );
  }

  /// `Помощь`
  String get onBoardingTwoTtitlePart1 {
    return Intl.message(
      'Помощь',
      name: 'onBoardingTwoTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: кризисные центры, ссылки`
  String get onBoardingTwoTtitlePart2 {
    return Intl.message(
      ': кризисные центры, ссылки',
      name: 'onBoardingTwoTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `В случае необходимости мы готовы предоставить вам помощь и поддержку. Обратитесь к нашим кризисным центрам и найдите полезные ссылки.`
  String get onBoardingTwoDesc {
    return Intl.message(
      'В случае необходимости мы готовы предоставить вам помощь и поддержку. Обратитесь к нашим кризисным центрам и найдите полезные ссылки.',
      name: 'onBoardingTwoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Новости`
  String get onBoardingThreeTtitlePart1 {
    return Intl.message(
      'Новости',
      name: 'onBoardingThreeTtitlePart1',
      desc: '',
      args: [],
    );
  }

  /// `: события и не только`
  String get onBoardingThreeTtitlePart2 {
    return Intl.message(
      ': события и не только',
      name: 'onBoardingThreeTtitlePart2',
      desc: '',
      args: [],
    );
  }

  /// `Будьте в курсе последних событий и новостей, связанных с движением ЛГБТ. От улучшения прав ЛГБТ-сообщества до важных моментов и достижений.`
  String get onBoardingThreeDesc {
    return Intl.message(
      'Будьте в курсе последних событий и новостей, связанных с движением ЛГБТ. От улучшения прав ЛГБТ-сообщества до важных моментов и достижений.',
      name: 'onBoardingThreeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Начать`
  String get onBoardingButtonToBegin {
    return Intl.message(
      'Начать',
      name: 'onBoardingButtonToBegin',
      desc: '',
      args: [],
    );
  }

  /// `О приложении`
  String get settingsAbout {
    return Intl.message(
      'О приложении',
      name: 'settingsAbout',
      desc: '',
      args: [],
    );
  }

  /// `О приложении`
  String get settingsAboutApp {
    return Intl.message(
      'О приложении',
      name: 'settingsAboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Пользовательское соглашение`
  String get settingsPrivacyPolice {
    return Intl.message(
      'Пользовательское соглашение',
      name: 'settingsPrivacyPolice',
      desc: '',
      args: [],
    );
  }

  /// `О здоровье`
  String get navigationGuides {
    return Intl.message(
      'О здоровье',
      name: 'navigationGuides',
      desc: '',
      args: [],
    );
  }

  /// `Помощь`
  String get navigationHelp {
    return Intl.message(
      'Помощь',
      name: 'navigationHelp',
      desc: '',
      args: [],
    );
  }

  /// `Новости`
  String get navigationArticles {
    return Intl.message(
      'Новости',
      name: 'navigationArticles',
      desc: '',
      args: [],
    );
  }

  /// `Контакты`
  String get helpCategoriesTitle {
    return Intl.message(
      'Контакты',
      name: 'helpCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Не нашли что что искали?`
  String get helpDidntFindTitle {
    return Intl.message(
      'Не нашли что что искали?',
      name: 'helpDidntFindTitle',
      desc: '',
      args: [],
    );
  }

  /// `Полезные ссылки`
  String get helpDidntFindUsefulllinks {
    return Intl.message(
      'Полезные ссылки',
      name: 'helpDidntFindUsefulllinks',
      desc: '',
      args: [],
    );
  }

  /// `Запросить помощь`
  String get helpDidntFindHelp {
    return Intl.message(
      'Запросить помощь',
      name: 'helpDidntFindHelp',
      desc: '',
      args: [],
    );
  }

  /// `Полезные ссылки`
  String get usefullLinksTitle {
    return Intl.message(
      'Полезные ссылки',
      name: 'usefullLinksTitle',
      desc: '',
      args: [],
    );
  }

  /// `Язык`
  String get settingsLangTitle {
    return Intl.message(
      'Язык',
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

  /// `Загрузка...`
  String get titleLoading {
    return Intl.message(
      'Загрузка...',
      name: 'titleLoading',
      desc: '',
      args: [],
    );
  }

  /// `Помогает с`
  String get contactItemModalLabelDescription {
    return Intl.message(
      'Помогает с',
      name: 'contactItemModalLabelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Адрес`
  String get contactItemModalLabelAddress {
    return Intl.message(
      'Адрес',
      name: 'contactItemModalLabelAddress',
      desc: '',
      args: [],
    );
  }

  /// `Открыть карту`
  String get contactItemModalLabelOpenMap {
    return Intl.message(
      'Открыть карту',
      name: 'contactItemModalLabelOpenMap',
      desc: '',
      args: [],
    );
  }

  /// `Контакты`
  String get contactItemModalLabelContacts {
    return Intl.message(
      'Контакты',
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
