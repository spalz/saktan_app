import 'package:flutter/material.dart';
import 'package:saktan_app/widgets/widgets.dart';

class GuidesChaptersListSkeleton extends StatelessWidget {
  const GuidesChaptersListSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const TopProgressIndicator(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          padding:
              const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 80),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 62,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Add skeleton color here
                    borderRadius:
                        BorderRadius.circular(20), // Add border radius here
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}
