import 'package:flutter/material.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const ModalAppBar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      titleSpacing: 20,
      leading: Container(),
      leadingWidth: 0,
      centerTitle: false,
      title: Text(
        title,
        maxLines: 2,
        style: const TextStyle(height: 1.3),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
