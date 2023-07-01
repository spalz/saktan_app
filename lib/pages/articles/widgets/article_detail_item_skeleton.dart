import 'package:flutter/material.dart';

class ArticleDetailTtemSkeleton extends StatelessWidget {
  const ArticleDetailTtemSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 0),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
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
                    color: Colors.grey[300], // Add skeleton color here
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: textTheme.titleLarge!.fontSize,
              width: double.infinity,
              color: Colors.grey[300], // Add skeleton color here
            ),
            const SizedBox(height: 10),
            Container(
              height: textTheme.bodySmall!.fontSize!,
              width: double.infinity,
              color: Colors.grey[300], // Add skeleton color here
            ),
          ],
        ),
      ),
    );
  }
}
