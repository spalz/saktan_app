import 'package:flutter/material.dart';
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';

// import '../../chapters/guides_chapters_screen.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({
    required this.article,
    // required this.showDescription, // Добавлено новое поле
    Key? key,
  }) : super(key: key);

  final Article article;
  // final bool showDescription; // Добавлено новое поле

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
        // subtitle: showDescription
        //     ? Text(
        //         article
        //             .description, // Показываем описание только для первого элемента
        //         style: textTheme.labelSmall,
        //       )
        //     : null,
        dense: true,
        onTap: () {},
      ),
    );
  }
}
