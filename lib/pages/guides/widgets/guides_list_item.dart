import 'package:cached_network_image/cached_network_image.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        horizontalTitleGap: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.grey[100],
        focusColor: Colors.blue[100],
        splashColor: Colors.blue[100],
        minVerticalPadding: 22,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: CachedNetworkImage(
          width: 32,
          height: 32,
          placeholder: (BuildContext context, String url) => Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              )),
          fadeOutDuration: const Duration(milliseconds: 300),
          fadeInDuration: const Duration(milliseconds: 300),
          imageUrl: guide.icon,
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
      ),
    );
  }
}
