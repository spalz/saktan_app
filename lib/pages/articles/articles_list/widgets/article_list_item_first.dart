import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';

class ArticleListItemFirst extends StatelessWidget {
  const ArticleListItemFirst({
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
      margin: const EdgeInsets.only(bottom: 25),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.grey.shade100,
                        ),
                      ),
                      child: Image.network(
                        '${article.image}?format=webp&width=800&embed',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                article.title,
                style: TextStyle(
                  fontFamily: textTheme.titleLarge!.fontFamily,
                  fontSize: textTheme.titleLarge!.fontSize,
                  fontWeight: textTheme.titleLarge!.fontWeight,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                article.description,
                style: textTheme.bodySmall,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                formattedDate,
                style: textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
