import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:saktan_app/pages/help/help.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.article,
    Key? key,
  }) : super(key: key);

  final ContactList article;

  @override
  Widget build(BuildContext context) {
    const String trailingSvg = 'assets/images/icons/trailing_contacts.svg';
    final Widget trailing =
        SvgPicture.asset(trailingSvg, width: 32, alignment: Alignment.topLeft);

    final textTheme = Theme.of(context).textTheme;
    return ListTile(
        focusColor: Colors.transparent,
        splashColor: const Color.fromRGBO(240, 244, 255, 1),
        title: Text(
          article.titleRu,
          style: textTheme.titleSmall,
        ),
        minVerticalPadding: 15,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        horizontalTitleGap: 20,
        subtitle: article.descriptionRu != null
            ? Text(article.descriptionRu!,
                style: TextStyle(
                  fontSize: textTheme.labelSmall!.fontSize,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(51, 51, 51, 1),
                ))
            : null,
        trailing: trailing,
        onTap: () => showBarModalBottomSheet(
              context: context,
              builder: (context) => ContactItemModal(id: article.id),
            ));
  }
}
