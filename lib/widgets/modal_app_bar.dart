import 'package:flutter/material.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ModalAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      titleSpacing: 20,
      leading: Container(),
      leadingWidth: 0,
      centerTitle: false,
      title: Text(
        title,
        maxLines: 2,
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
