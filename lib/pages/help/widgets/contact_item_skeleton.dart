import 'package:flutter/material.dart';
import 'package:saktan_app/widgets/widgets.dart';

class ContactSkeleton extends StatelessWidget {
  const ContactSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TopProgressIndicator();
  }
}
