import 'package:flutter/material.dart';
import 'package:saktan_app/pages/guides/categories/categories.dart';

import '../../chapters/guides_chapters_screen.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
        child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: Colors.grey[200],
      focusColor: Colors.blue[200],
      splashColor: Colors.blue[200],
      minVerticalPadding: 22,
      leading: Image.network(
        category.icon,
        width: 38,
      ),
      title: Text(
        category.titleRu,
        style: textTheme.titleSmall,
      ),
      dense: true,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AboutHealthChapters(slug: category.slug)));
      },
    ));
  }
}
