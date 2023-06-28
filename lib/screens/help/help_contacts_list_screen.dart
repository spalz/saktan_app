import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/screens/help/help_contact_item_modal.dart';

class HelpContactsListScreen extends StatefulWidget {
  const HelpContactsListScreen({Key? key}) : super(key: key);

  @override
  State<HelpContactsListScreen> createState() => _HelpContactsListScreenState();
}

class _HelpContactsListScreenState extends State<HelpContactsListScreen> {
  @override
  void initState() {
    super.initState();
  }

  void initialization() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Гос. центры / больницы"),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white), // add this line
        titleTextStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.grey[200],
                        focusColor: Colors.blue[200],
                        splashColor: Colors.blue[200],
                        minVerticalPadding: 22,
                        title: Text(
                          "Республиканский центр «СПИД» МЗ КР",
                          style: theme.textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          "ВИЧ и СПИД, Профилактика, Тестирование, Лечение",
                          style: theme.textTheme.labelSmall,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => showBarModalBottomSheet(
                          // expand: true,
                          context: context,
                          builder: (context) => const HelpContactItemModal(),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
