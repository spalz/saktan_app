import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.value,
    required this.icon,
    required this.onTap,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? value;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      minVerticalPadding: 20,
      splashColor: Colors.transparent,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: textTheme.bodyMedium!.fontSize,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
      trailing: value != null
          ? Text(
              value!,
              style: TextStyle(
                fontSize: textTheme.bodyMedium!.fontSize,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                height: 1.4,
              ),
            )
          : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
