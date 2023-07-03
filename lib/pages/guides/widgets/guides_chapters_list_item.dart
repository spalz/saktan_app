import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

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

    const String trailingSvg = 'assets/images/icons/trailing_right.svg';
    final Widget trailing =
        SvgPicture.asset(trailingSvg, width: 32, alignment: Alignment.topLeft);

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
          trailing: trailing,
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
