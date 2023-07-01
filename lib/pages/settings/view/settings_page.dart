import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/generated/l10n.dart';

import '../../../main.dart';

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
      // S.load(Locale(languageCode));
      _currentLanguage = languageCode;

      SaktanApp.setLocale(context, Locale(languageCode, ""));
    });
    // Здесь можно добавить логику для перевода приложения на выбранный язык
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('О приложении'),
            onTap: () {
              // Обработка нажатия на ссылку "О приложении"
              // Здесь можно добавить соответствующую логику
            },
          ),
          ListTile(
            title: const Text('Пользовательское соглашение'),
            onTap: () {
              // Обработка нажатия на ссылку "Пользовательское соглашение"
              // Здесь можно добавить соответствующую логику
            },
          ),
          ListTile(
            title: const Text('Язык'),
            trailing: DropdownButton<String>(
              value: _currentLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: 'ru',
                  child: Text('Русский'),
                ),
                DropdownMenuItem(
                  value: 'ky',
                  child: Text('Кыргызский'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
