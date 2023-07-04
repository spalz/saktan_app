import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:saktan_app/widgets/widgets.dart';

class ContactItemModal extends StatefulWidget {
  final int id;
  final String title;
  const ContactItemModal({Key? key, required this.id, required this.title})
      : super(key: key);

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
        appBar: ModalAppBar(title: widget.title),
        body: SafeArea(
          bottom: false,
          child: Container(
            child: _isLoadRunning
                ? Container(
                    alignment: Alignment.topCenter,
                    child: const LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(90, 220, 190, 1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(240, 244, 255, 1),
                      ),
                    ),
                  )
                : Column(children: [
                    if (_contact!.descriptionRu != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            S.of(context).contactItemModalLabelDescription,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          subtitle: Text(getT(locale, _contact!.descriptionRu,
                              _contact!.descriptionKy)),
                        ),
                      ),
                    // ignore: unnecessary_null_comparison
                    if (_contact!.addressRu != null ||
                        // ignore: unnecessary_null_comparison
                        _contact!.addressKy != null)
                      ListTile(
                        title: Text(
                          S.of(context).contactItemModalLabelAddress,
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
                                child: Text(
                                  S.of(context).contactItemModalLabelOpenMap,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(60, 105, 220, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ListTile(
                      title: Text(
                        S.of(context).contactItemModalLabelContacts,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var phone in _contact!.phones ?? [])
                            Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                              fontSize:
                                                  textTheme.bodyLarge!.fontSize,
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
                                        color: Color.fromRGBO(60, 105, 220, 1),
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
                  ]),
          ),
        ),
      ),
    );
  }
}
