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
  bool _isLoadRunning = true;
  Future<void>? launched;
  List<ContactCategoryList> _categories = <ContactCategoryList>[];

  void _firstLoad() async {
    setState(() {
      _isLoadRunning = true;
    });

    final fetchedContactsCategories = await fetchContactsCategories();
    if (mounted) {
      setState(() {
        _categories = fetchedContactsCategories;
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadRunning = false;
        });
      }
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
    var theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(logo: "saktan", centerTitle: false),
      body: SingleChildScrollView(
        child: _isLoadRunning
            ? const ContactsCategoriesSkeleton()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).helpCategoriesTitle,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.titleMedium,
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
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              S.of(context).helpDidntFindTitle,
                              style: theme.textTheme.titleMedium,
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
