import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../globals.dart' as globals;
import '../model/EditorJSData.dart';
import 'components/youtube_video_player.dart';

class EditorJSView extends StatefulWidget {
  final String? editorJSData;
  final String? styles;

  const EditorJSView({Key? key, this.editorJSData, this.styles})
      : super(key: key);

  @override
  EditorJSViewState createState() => EditorJSViewState();
}

class EditorJSViewState extends State<EditorJSView> {
  late EditorJSData dataObject;
  final List<Widget> items = <Widget>[];

  @override
  void initState() {
    super.initState();

    dataObject = EditorJSData.fromJson(jsonDecode(widget.editorJSData!));
  }

  @override
  Widget build(BuildContext context) {
    for (var element in dataObject.blocks!) {
      var levelFontSize =
          FontSize(Theme.of(context).textTheme.headlineSmall!.fontSize!);
      var levelColor = Colors.blue;

      switch (element.data!.level) {
        case 1:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineLarge!.fontSize!);
          levelColor = Colors.red;
          break;
        case 2:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineLarge!.fontSize!);
          levelColor = Colors.green;
          break;
        case 3:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineMedium!.fontSize!);
          levelColor = Colors.brown;
          break;
        case 4:
          levelColor = Colors.purple;
          break;
        case 5:
          levelColor = Colors.orange;
          break;
        case 6:
          levelColor = Colors.grey;
          break;
      }

      switch (element.type) {
        case "Header":
          items.add(Html(
            data: element.data!.text,
            style: {
              "body": Style(
                  fontFamily:
                      Theme.of(context).textTheme.headlineLarge!.fontFamily,
                  margin: Margins.zero,
                  color: levelColor,
                  fontSize: levelFontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineLarge!.fontWeight),
            },
          ));
          break;
        case "paragraph":
          items.add(Html(
            data: element.data!.text,
            style: {
              "body": Style(margin: Margins.zero),
              "code": Style(backgroundColor: Colors.grey, color: Colors.white),
              "mark": Style(backgroundColor: Colors.blue, color: Colors.white),
            },
          ));
          break;
        case "List":
          String bullet = "\u2022 ";
          String? style = element.data!.style;
          int counter = 1;

          for (var element in element.data!.items!) {
            if (style == 'ordered') {
              bullet = counter.toString();
              items.add(
                Row(children: [
                  Expanded(
                    child: Html(
                      data: bullet + element,
                      style: {
                        "body": Style(margin: Margins.zero, color: Colors.red),
                      },
                    ),
                  )
                ]),
              );
              counter++;
            } else {
              items.add(
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Html(
                        data: bullet + element,
                        style: {
                          "body": Style(margin: Margins.zero),
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          }
          break;
        case "delimiter":
          items.add(const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(child: Divider(color: Colors.grey))]));
          break;
        case "image":
          items.add(Image.network(globals.apiUrl + element.data!.file!.url!));
          break;
        case "Embed":
          items.add(
            YoutubeVideoPlayer(
              videoUrl: element.data!.source!,
              caption: element.data!.caption!,
            ),
          );
          break;
        // Другие случаи...
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: items,
    );
  }
}
