import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

class ContactCategoryItem extends StatelessWidget {
  const ContactCategoryItem({
    required this.article,
    Key? key,
  }) : super(key: key);

  final ContactCategoryList article;

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    final textTheme = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.grey[200],
          focusColor: Colors.blue[200],
          splashColor: Colors.blue[200],
          minVerticalPadding: 22,
          title: Text(
            getT(locale, article.titleRu, article.titleKy),
            style: textTheme.titleSmall,
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                article.descriptionRu,
                style: textTheme.labelSmall,
              )),
          // trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactsListPage(slug: article.slug)));
          },
        ));
  }
}
