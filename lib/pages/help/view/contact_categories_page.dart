import 'package:flutter/material.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:saktan_app/widgets/widgets.dart';

class ContactCategoriesPage extends StatefulWidget {
  const ContactCategoriesPage({Key? key}) : super(key: key);

  @override
  State<ContactCategoriesPage> createState() => ContacsCategoriesPageState();
}

class ContacsCategoriesPageState extends State<ContactCategoriesPage> {
  bool _isLoadRunning = false;
  Future<void>? launched;
  List<ContactCategoryList> _categories = <ContactCategoryList>[];

  void _firstLoad() async {
    setState(() {
      _isLoadRunning = false;
    });

    final fetchedContactsCategories = await fetchContactsCategories();
    if (mounted) {
      // Check if the widget is still mounted
      setState(() {
        _categories = fetchedContactsCategories;
      });
    }

    if (mounted) {
      // Check if the widget is still mounted
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          // Check if the widget is still mounted
          setState(() {
            _isLoadRunning = false;
          });
        }
      });
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
    var theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(logo: "saktan", centerTitle: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _isLoadRunning
              ? const ContactCategorySkeleton()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).helpCategoriesTitle,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _categories.length,
                      itemBuilder: (_, index) =>
                          ContactCategoryItem(article: _categories[index]),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              S.of(context).helpDidntFindTitle,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          GlobalCard(
                            trailing: const Icon(SaktanIcons.helpusefulllinks),
                            title: S.of(context).helpDidntFindUsefulllinks,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const UsefulLinksPage()));
                            },
                          ),
                          GlobalCard(
                            trailing: const Icon(SaktanIcons.help),
                            title: S.of(context).helpDidntFindHelp,
                            onTap: () {
                              launchInBrowser(
                                  Uri.parse("https://indigo.kg/helps"));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
