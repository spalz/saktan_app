import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

class GuidesListItem extends StatelessWidget {
  const GuidesListItem({
    required this.guide,
    Key? key,
  }) : super(key: key);

  final GuidesList guide;

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
          leading: Image.network(
            guide.icon,
            width: 38,
          ),
          title: Text(
            getT(locale, guide.titleRu, guide.titleKy),
            style: textTheme.titleSmall,
          ),
          dense: true,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChaptersListPage(
                    id: guide.id,
                    title: getT(locale, guide.titleRu, guide.titleKy))));
          },
        ));
  }
}
