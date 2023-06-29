import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({
    required this.article,
    Key? key,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final publishedDate = DateTime.parse(article.published);
    final formattedDate = DateFormat('dd MMM yyyy').format(publishedDate);
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                width: 90,
                height: 90,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${article.image}?format=webp&width=250&embed',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15, right: 0),
                  title: Text(article.title,
                      style: TextStyle(
                        fontFamily: textTheme.titleSmall!.fontFamily,
                        fontSize: 16,
                        fontWeight: textTheme.titleSmall!.fontWeight,
                        height: 1.4,
                      )),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        formattedDate,
                        style: textTheme.labelSmall,
                      )),
                  dense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
