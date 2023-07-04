import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/main.dart';
import 'package:saktan_app/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String _currentLanguage = Intl.getCurrentLocale(); // Текущий выбранный язык

  void _changeLanguage(String languageCode) {
    if (kDebugMode) {
      print('languageCode: $languageCode');
    }
    setState(() {
      _currentLanguage = languageCode;
      SaktanApp.setLocale(context, Locale(languageCode, ""));
    });
    // Здесь можно добавить логику для перевода приложения на выбранный язык
    Navigator.pop(context); // Закрытие модального окна после выбора языка
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(S.of(context).settingsAbout),
            onTap: () {
              // Обработка нажатия на ссылку "О приложении"
              // Здесь можно добавить соответствующую логику
            },
          ),
          ListTile(
            title: Text(S.of(context).settingsPrivacyPolice),
            onTap: () {
              // Обработка нажатия на ссылку "Пользовательское соглашение"
              // Здесь можно добавить соответствующую логику
            },
          ),
          ListTile(
            title: Text(S.of(context).settingsLangTitle),
            onTap:
                _showLanguageModal, // Вызов метода для отображения модального окна выбора языка
          ),
        ],
      ),
    );
  }

  // Метод для отображения модального окна выбора языка
  void _showLanguageModal() {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ModalAppBar(title: S.of(context).settingsLangTitle),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    final languageCode = index == 0 ? 'ru' : 'ky';
                    final languageTitle = index == 0
                        ? S.of(context).settingsLangTitleRu
                        : S.of(context).settingsLangTitleKy;
                    final isSelected = _currentLanguage == languageCode;

                    return ListTile(
                      title: Text(languageTitle),
                      trailing: isSelected
                          ? const Icon(SaktanIcons.settingscheck)
                          : const Icon(SaktanIcons
                              .settingsuncheck), // Пустой trailing для остальных языков
                      onTap: () {
                        setState(() {
                          _changeLanguage(languageCode);
                        });
                      },
                    );
                  },
                ),
              ],
            ));
          },
        );
      },
    );
  }
}
