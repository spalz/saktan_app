import 'package:flutter/material.dart';
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';

// import '../../chapters/guides_chapters_screen.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Image.network(
          article.image,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          article.title,
          style: textTheme.titleSmall,
        ),
        dense: true,
        onTap: () {},
      ),
    );
  }
}
