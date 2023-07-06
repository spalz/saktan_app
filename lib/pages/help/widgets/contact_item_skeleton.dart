import 'package:flutter/material.dart';

class ContactSkeleton extends StatelessWidget {
  const ContactSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      backgroundColor: Color.fromRGBO(90, 220, 190, 1),
      valueColor: AlwaysStoppedAnimation<Color>(
        Color.fromRGBO(240, 244, 255, 1),
      ),
    );
  }
}
