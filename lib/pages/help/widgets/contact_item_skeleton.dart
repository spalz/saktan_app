import 'package:flutter/material.dart';

class ContactSkeleton extends StatelessWidget {
  const ContactSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 25),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
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
            const SizedBox(height: 25),
            Flex(direction: Axis.horizontal, children: [
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
                    child: Container(
                      color: Colors.grey[300], // Add skeleton color here
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 15, right: 0),
                  title: Container(
                    height: textTheme.titleSmall!.fontSize,
                    width: double.infinity,
                    color: Colors.grey[300], // Add skeleton color here
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: textTheme.labelSmall!.fontSize,
                      width: 80,
                      color: Colors.grey[300], // Add skeleton color here
                    ),
                  ),
                  dense: true,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
