import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:saktan_app/widgets/widgets.dart';

class GuidesChaptersListItem extends StatelessWidget {
  const GuidesChaptersListItem({
    required this.chapter,
    required this.index,
    required this.guide,
    Key? key,
  }) : super(key: key);

  final Chapter chapter;
  final GuideDetail guide;
  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    final theme = Theme.of(context);

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: Colors.grey[200],
          focusColor: Colors.blue[200],
          splashColor: Colors.blue[200],
          minVerticalPadding: 10,
          title: Text(getT(locale, chapter.titleRu, chapter.titleKy),
              style: TextStyle(
                fontSize: theme.textTheme.bodyMedium!.fontSize,
                fontWeight: FontWeight.w600,
              )),
          trailing: Icon(
            SaktanIcons.arrowright,
            size: 30,
            color: theme.primaryColor,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GuideDetailPage(
                      chapterIndex: index,
                      guide: guide,
                    )));
          },
        ));
  }
}
