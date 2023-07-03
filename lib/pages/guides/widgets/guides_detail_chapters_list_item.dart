import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/editorjs/editorjs.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class GuidesDetailChaptersListItem extends StatelessWidget {
  const GuidesDetailChaptersListItem({
    required this.chapter,
    required this.itemKey,
    required this.index,
    Key? key,
  }) : super(key: key);

  final Chapter chapter;
  final Key itemKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    final theme = Theme.of(context);

    return StickyHeader(
      key: itemKey,
      header: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        color: Colors.white,
        child: Container(
          height: 80.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: theme.primaryColorLight,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  getT(locale, chapter.titleRu, chapter.titleKy),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
      content: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: EditorJSView(
            editorJSData: getT(locale, chapter.bodyRu, chapter.bodyKy)),
      ),
    );
  }
}
