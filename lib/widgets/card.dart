import 'package:flutter/material.dart';

class GlobalCard extends StatelessWidget {
  const GlobalCard({
    super.key,
    required this.trailing,
    required this.title,
    required this.onTap,
  });

  final Widget? trailing;
  final String title;
  final Null Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: const Color.fromRGBO(240, 244, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Установите требуемый радиус скругления
      ),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(10)), // Установите радиус скругления для Ink
        ),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: const Color.fromRGBO(215, 255, 246, 1),
          borderRadius: BorderRadius.circular(
              10), // Установите радиус скругления для InkWell
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  trailing: trailing,
                  contentPadding: const EdgeInsets.only(left: 20, right: 15),
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
