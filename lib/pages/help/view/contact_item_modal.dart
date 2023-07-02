import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

class ContactItemModal extends StatefulWidget {
  final int id;
  const ContactItemModal({Key? key, required this.id}) : super(key: key);

  @override
  State<ContactItemModal> createState() => ContactItemModalState();
}

class ContactItemModalState extends State<ContactItemModal> {
  bool _isLoadRunning = true;
  ContactDetail? _contact;

  late final int _id = widget.id;

  void _firstLoad() async {
    try {
      setState(() {
        _isLoadRunning = true;
      });

      final fetchedContact = await fetchContactDetail(_id);
      setState(() {
        _contact = fetchedContact;
        _isLoadRunning = false;
      });
    } catch (err) {
      // Handle the error, show an error message, etc.
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    final textTheme = Theme.of(context).textTheme;

    List<String> coordinateParts = [];
    if (_contact != null && _contact!.addressCoordinates != null) {
      coordinateParts = _contact!.addressCoordinates!.split(',');
    }

    double latitude = 0.0;
    double longitude = 0.0;
    if (coordinateParts.length == 2) {
      latitude = double.parse(coordinateParts[0]);
      longitude = double.parse(coordinateParts[1]);
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          titleSpacing: 20,
          leading: Container(),
          leadingWidth: 0,
          centerTitle: false,
          title: Text(
            _contact != null
                ? getT(locale, _contact!.titleRu, _contact!.titleKy)
                : "Загрузка...",
            maxLines: 2,
          ),
          backgroundColor: const Color.fromRGBO(240, 244, 255, 1),
        ),
        body: SafeArea(
          bottom: false,
          child: PageView(
            children: _isLoadRunning
                ? [
                    Container(
                      alignment: Alignment.topCenter,
                      child: const LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(90, 220, 190, 1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(240, 244, 255, 1),
                        ),
                      ),
                    ),
                  ]
                : List.generate(
                    1,
                    (pageIndex) => ListView(
                      shrinkWrap: true,
                      controller: ModalScrollController.of(context),
                      children: ListTile.divideTiles(
                        context: context,
                        color: const Color.fromRGBO(231, 239, 255, 1),
                        tiles: [
                          if (_contact!.descriptionRu != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(
                                  'Помогает с',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                subtitle: Text(getT(
                                    locale,
                                    _contact!.descriptionRu,
                                    _contact!.descriptionKy)),
                              ),
                            ),
                          // ignore: unnecessary_null_comparison
                          if (_contact!.addressRu != null ||
                              // ignore: unnecessary_null_comparison
                              _contact!.addressKy != null)
                            ListTile(
                              title: Text(
                                'Адрес',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getT(locale, _contact!.addressRu,
                                      _contact!.addressKy)),
                                  if (_contact!.addressCoordinates != null)
                                    GestureDetector(
                                      onTap: () {
                                        MapsLauncher.launchCoordinates(
                                          latitude,
                                          longitude,
                                          getT(locale, _contact!.addressRu,
                                              _contact!.addressKy),
                                        );
                                      },
                                      child: const Text(
                                        'Открыть карту',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(60, 105, 220, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ListTile(
                            title: Text(
                              'Контакты',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var phone in _contact!.phones ?? [])
                                  Flex(
                                    direction: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          makePhoneCall(
                                              cleanPhoneNumber(phone.phone));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: phone.phone,
                                                  style: TextStyle(
                                                    fontSize: textTheme
                                                        .bodyLarge!.fontSize,
                                                    color: const Color.fromRGBO(
                                                        60, 105, 220, 1),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                if (phone.name != null)
                                                  TextSpan(
                                                    text: ' ${phone.name}',
                                                    style: textTheme.bodyLarge!,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (_contact!.email != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            makeEmail(_contact!.email!);
                                          },
                                          child: Text(
                                            _contact!.email!,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  60, 105, 220, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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