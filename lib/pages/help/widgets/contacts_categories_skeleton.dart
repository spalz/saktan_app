import 'package:flutter/material.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/widgets/widgets.dart';

class ContactsCategoriesSkeleton extends StatelessWidget {
  const ContactsCategoriesSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: [
        const TopProgressIndicator(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).helpCategoriesTitle,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Add skeleton color here
                          borderRadius: BorderRadius.circular(
                              20), // Add border radius here
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
