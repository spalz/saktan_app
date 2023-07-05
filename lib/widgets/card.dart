import 'package:flutter/material.dart';

class GlobalCard extends StatelessWidget {
  const GlobalCard({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
  });

  final Widget? leading;
  final String title;
  final Null Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 0),
      elevation: 0,
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  leading: leading,
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  minVerticalPadding: 0,
                  title: Text(
                    title,
                    style: TextStyle(
                      fontFamily: textTheme.titleSmall!.fontFamily,
                      fontSize: textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
