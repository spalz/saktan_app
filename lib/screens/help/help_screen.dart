import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/screens/help/help_contacts_list_screen.dart';
import 'package:saktan_app/screens/help/help_useful_links_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  void initialization() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
    final Widget saktanLogo = SvgPicture.asset(saktanLogoSvg,
        width: 100,
        alignment: Alignment.topLeft,
        // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: 'Saktan');
    return Scaffold(
      appBar: AppBar(
        title: saktanLogo,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // show special container for last index
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Контакты',
                            textAlign: TextAlign.left,
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    );
                  }
                  if (index == 4) {
                    // show special container for last index
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Не нашли что что искали?',
                            style: theme.textTheme.titleLarge,
                          ),
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tileColor: Colors.grey[200],
                            focusColor: Colors.blue[200],
                            splashColor: Colors.blue[200],
                            minVerticalPadding: 22,
                            title: Text(
                              "Полезные ссылки",
                              style: theme.textTheme.titleSmall,
                            ),
                            // trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const HelpUsefulLinksScreen()));
                            },
                          ),
                        ],
                      ),
                    );
                  }
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
                          "Государственные центры / больницы",
                          style: theme.textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          "ListTile",
                          style: theme.textTheme.labelSmall,
                        ),
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const HelpContactsListScreen()));
                        },
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
