import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/pages/help/help.dart';

class ContactsListPage extends StatefulWidget {
  final String slug;
  const ContactsListPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<ContactsListPage> createState() => ContacstPageState();
}

class ContacstPageState extends State<ContactsListPage> {
  bool _isFirstLoadRunning = false;
  List<ContactList> _contacts = <ContactList>[];

  late final String _slug = widget.slug;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = false;
    });

    final fetchedContacts = await fetchContacts(_slug);
    setState(() {
      _contacts = fetchedContacts;
    });

    setState(() {
      _isFirstLoadRunning = false;
    });
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
    const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
    final Widget saktanLogo = SvgPicture.asset(saktanLogoSvg,
        width: 100, alignment: Alignment.topLeft, semanticsLabel: 'Saktan');
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 23,
        leading: Container(),
        leadingWidth: 0,
        title: saktanLogo,
        centerTitle: false,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 0, bottom: 80),
          child: _isFirstLoadRunning
              ? const ContactSkeleton()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Color.fromRGBO(231, 239, 255, 1),
                        height: 1,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _contacts.length,
                      itemBuilder: (_, index) =>
                          ContactItem(article: _contacts[index]),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
