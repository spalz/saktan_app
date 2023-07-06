import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:saktan_app/widgets/widgets.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.article,
    Key? key,
  }) : super(key: key);

  final ContactList article;

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();

    final textTheme = Theme.of(context).textTheme;
    return ListTile(
        focusColor: Colors.transparent,
        splashColor: const Color.fromRGBO(240, 244, 255, 1),
        title: Text(
          getT(locale, article.titleRu, article.titleKy),
          style: textTheme.titleSmall,
        ),
        minVerticalPadding: 15,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        horizontalTitleGap: 20,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.descriptionRu != null)
              Text(getT(locale, article.descriptionRu, article.descriptionKy),
                  style: TextStyle(
                    fontSize: textTheme.labelSmall!.fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  )),
            if (article.addressRu.isNotEmpty)
              Text(getT(locale, article.addressRu, article.addressKy),
                  style: TextStyle(
                    fontSize: textTheme.labelSmall!.fontSize,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ))
          ],
        ),
        trailing: Icon(SaktanIcons.helpcontact,
            size: 32, color: Theme.of(context).primaryColor),
        onTap: () => showBarModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              expand: true,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              // barrierColor: Colors.transparent,
              context: context,
              builder: (context) => ContactItemModal(
                  id: article.id,
                  title: getT(locale, article.titleRu, article.titleKy)),
            ));
  }
}
