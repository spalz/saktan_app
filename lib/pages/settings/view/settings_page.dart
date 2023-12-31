import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/main.dart';
import 'package:saktan_app/pages/settings/settings.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:saktan_app/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String _currentLanguage = Intl.getCurrentLocale();

  void _changeLanguage(String languageCode) {
    if (kDebugMode) {
      print('languageCode: $languageCode');
    }
    setState(() {
      _currentLanguage = languageCode;
      SaktanApp.setLocale(context, Locale(languageCode, ""));
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const String indigoLogoSvg = 'assets/images/logo/indigo.svg';
    final Widget indigoLogo = SvgPicture.asset(indigoLogoSvg,
        width: 70, alignment: Alignment.topLeft);

    const String dcLogoSvg = 'assets/images/logo/dc.svg';
    final Widget dcLogo =
        SvgPicture.asset(dcLogoSvg, width: 70, alignment: Alignment.topLeft);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingsTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey[200],
                );
              },
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SettingsListItem(
                    title: S.of(context).settingsAbout,
                    icon: SaktanIcons.settingsabout,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsAboutPage()));
                    },
                  );
                } else if (index == 1) {
                  return SettingsListItem(
                    title: S.of(context).settingsPrivacyPolice,
                    icon: SaktanIcons.settingsprivacypolice,
                    onTap: () {
                      launchInBrowser(
                          Uri.parse("https://indigo.kg/page/privacy-policy"));
                    },
                  );
                } else {
                  return SettingsListItem(
                    title: S.of(context).settingsLangTitle,
                    icon: SaktanIcons.settingslang,
                    value: _currentLanguage == "ru"
                        ? S.of(context).settingsLangTitleRu
                        : S.of(context).settingsLangTitleKy,
                    onTap: _showLanguageModal,
                  );
                }
              },
            ),
          ),
          SafeArea(
            bottom: true,
            child: SizedBox(
              width: double.infinity,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'support of',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 5),
                          indigoLogo,
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          launchInBrowser(
                              Uri.parse("https://dangercactus.io/"));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'developed',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 5),
                            dcLogo,
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageModal() {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ModalAppBar(
                  title: S.of(context).settingsLangTitle,
                  height: 80,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 2,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey[200],
                    );
                  },
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                  itemBuilder: (BuildContext context, int index) {
                    final languageCode = index == 0 ? 'ru' : 'ky';
                    final languageTitle = index == 0
                        ? S.of(context).settingsLangTitleRu
                        : S.of(context).settingsLangTitleKy;
                    final isSelected = _currentLanguage == languageCode;

                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(languageTitle,
                          style: const TextStyle(
                            // fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      trailing: isSelected
                          ? const Icon(SaktanIcons.settingscheck,
                              size: 32, color: Color.fromRGBO(60, 105, 220, 1))
                          : Icon(SaktanIcons.settingsuncheck,
                              size: 32, color: Colors.grey[300]),
                      onTap: () {
                        setState(() {
                          _changeLanguage(languageCode);
                        });
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
