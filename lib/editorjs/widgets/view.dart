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
      var levelColor = Colors.black87;
      var levelMarginTop = 15;
      var levelMarginBottom = 10;
      var levelHeight = 1.3;

      switch (element.data!.level) {
        case 1:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineLarge!.fontSize!);
          levelColor = Colors.red;
          levelHeight = 1.4;
          break;
        case 2:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineLarge!.fontSize!);
          levelColor = Colors.green;
          levelHeight = 1.4;
          break;
        case 3:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineMedium!.fontSize!);
          levelColor = Colors.brown;
          break;
        case 4:
          break;
        case 5:
          break;
        case 6:
          break;
      }

      switch (element.type) {
        case "Header":
          items.add(Html(
            data: element.data!.text,
            style: {
              "body": Style(
                  margin: Margins.only(
                    left: 0,
                    top: levelMarginTop.toDouble(),
                    right: 0,
                    bottom: levelMarginBottom.toDouble(),
                  ),
                  lineHeight: LineHeight(levelHeight.toDouble()),
                  fontFamily:
                      Theme.of(context).textTheme.headlineLarge!.fontFamily,
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
              "body": Style(
                  margin: Margins.only(left: 0, top: 0, right: 0, bottom: 15)),
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
              items.add(Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 10),
                child: Row(children: [
                  Expanded(
                    child: Html(
                      data: "$bullet" ". $element",
                      style: {
                        "body": Style(margin: Margins.zero),
                      },
                    ),
                  )
                ]),
              ));
              counter++;
            } else {
              items.add(Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 10),
                child: Row(
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
              ));
            }
          }
          break;
        case "delimiter":
          items.add(const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(child: Divider(color: Colors.grey))]));
          break;
        case "image":
          items.add(
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.network(globals.apiUrl + element.data!.file!.url!),
            ),
          );
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
