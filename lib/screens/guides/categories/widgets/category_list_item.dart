import 'package:flutter/material.dart';
import 'package:saktan_app/screens/guides/categories/categories.dart';

import '../../about_health_chapters_screen.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

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
        post.icon,
        width: 38,
      ),
      title: Text(
        post.titleRu,
        style: textTheme.titleSmall,
      ),
      dense: true,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AboutHealthChapters(slug: post.slug)));
      },
    ));
  }
}
