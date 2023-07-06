import 'package:flutter/material.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

class ContactsListPage extends StatefulWidget {
  final String slug;
  final String title;
  const ContactsListPage({Key? key, required this.slug, required this.title})
      : super(key: key);

  @override
  State<ContactsListPage> createState() => ContacstPageState();
}

class ContacstPageState extends State<ContactsListPage> {
  bool _isFirstLoadRunning = true;
  List<ContactList> _contacts = <ContactList>[];

  late final String _slug = widget.slug;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final fetchedContacts = await fetchContacts(_slug);
    setState(() {
      _contacts = fetchedContacts;
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: Colors.white,
        settings: false,
      ),
      body: _isFirstLoadRunning
          ? const ContactSkeleton()
          : ListView.separated(
              padding: const EdgeInsets.only(top: 0, bottom: 80),
              separatorBuilder: (context, index) => const Divider(
                color: Color.fromRGBO(231, 239, 255, 1),
                height: 1,
              ),
              itemCount: _contacts.length,
              itemBuilder: (_, index) => ContactItem(
                article: _contacts[index],
              ),
            ),
    );
  }
}
