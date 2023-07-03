import 'package:flutter/material.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/widgets/widgets.dart';

class GuidesListSkeleton extends StatelessWidget {
  const GuidesListSkeleton({
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
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  S.of(context).guideTitle,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 70,
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
