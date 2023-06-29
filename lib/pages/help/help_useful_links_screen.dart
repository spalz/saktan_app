import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HelpUsefulLinksScreen extends StatefulWidget {
  const HelpUsefulLinksScreen({Key? key}) : super(key: key);

  @override
  State<HelpUsefulLinksScreen> createState() => _HelpUsefulLinksScreenState();
}

class _HelpUsefulLinksScreenState extends State<HelpUsefulLinksScreen> {
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
        title: const Text('Полезные ссылки'),
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
            child: GridView.extent(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(5, (index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: const Color.fromRGBO(222, 248, 242, 1),
                  focusColor: Colors.blue[200],
                  splashColor: Colors.blue[200],
                  minVerticalPadding: 22,
                  title: const AutoSizeText(
                    "Практическое руководство по реализации комплексных программ по ВИЧ",
                    style: TextStyle(fontSize: 30),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    wrapWords: false,
                  ),
                  subtitle: Text(
                    "ВОЗ",
                    style: TextStyle(
                        fontSize: theme.textTheme.labelSmall!.fontSize!,
                        color: Colors.blue),
                  ),
                  // onTap: () {
                  //   launchUrl({})
                  // },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
