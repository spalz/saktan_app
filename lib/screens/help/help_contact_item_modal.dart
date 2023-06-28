import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpContactItemModal extends StatefulWidget {
  const HelpContactItemModal({super.key});

  @override
  State<HelpContactItemModal> createState() => HelpContactItemModalState();
}

class HelpContactItemModalState extends State<HelpContactItemModal> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // print('phone number: $phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String phoneNumber) async {
    // print('phone number: $phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          titleSpacing: 20,
          leading: Container(),
          leadingWidth: 0,
          title: const Text(
            'Республиканский центр «СПИД» МЗ КР',
            maxLines: 2,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: PageView(
            children: List.generate(
              1,
              (pageIndex) => ListView(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text('Помогает с',
                          style: Theme.of(context).textTheme.labelSmall),
                      subtitle: const Text(
                        'ВИЧ и СПИД, Профилактика, Тестирование, Лечение',
                      ),
                    ),
                    ListTile(
                      title: Text('Адрес',
                          style: Theme.of(context).textTheme.labelSmall),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('г. Бишкек, ул. 720040 Логвиненко, 8'),
                          GestureDetector(
                            onTap: () {
                              MapsLauncher.launchCoordinates(
                                  42.851393,
                                  74.581843,
                                  'Республиканский центр «СПИД» МЗ КР');
                            },
                            child: const Text(
                              'Открыть карту',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text('Контакты',
                          style: Theme.of(context).textTheme.labelSmall),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(direction: Axis.horizontal, children: [
                            GestureDetector(
                              onTap: () {
                                _makePhoneCall('+996 312 30-04-50');
                              },
                              child: const Text(
                                '+996 312 30-04-50',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const Text(' отдел МиО'),
                          ]),
                          Flex(direction: Axis.horizontal, children: [
                            GestureDetector(
                              onTap: () {
                                _makeEmail('rospid@mail.ru');
                              },
                              child: const Text(
                                'rospid@mail.ru',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            // const Text('отдел МиО'),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
