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

    return SelectionArea(
        child: StickyHeaderBuilder(
      key: itemKey,
      builder: (BuildContext context, double stuckAmount) {
        stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
        return Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 0,
          ),
          alignment: Alignment.centerLeft,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  Color.lerp(Colors.blue[50], theme.primaryColor, stuckAmount),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 15,
                right: 15,
                bottom: 8,
              ),
              child: Text(
                getT(locale, chapter.titleRu, chapter.titleKy),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: theme.textTheme.titleSmall!.fontSize,
                  color: Color.lerp(Colors.black87, Colors.white, stuckAmount),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        );
      },
      content: Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: EditorJSView(
          editorJSData: getT(locale, chapter.bodyRu, chapter.bodyKy),
          isGuide: true,
        ),
      ),
    ));
  }
}
