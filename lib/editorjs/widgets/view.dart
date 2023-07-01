import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:saktan_app/utils/utils.dart';

import '../../globals.dart' as globals;
import '../model/editorjs_data.dart';
import 'components/youtube_video_player.dart';

class EditorJSView extends StatefulWidget {
  final String? editorJSData;

  const EditorJSView({Key? key, this.editorJSData}) : super(key: key);

  @override
  EditorJSViewState createState() => EditorJSViewState();
}

class EditorJSViewState extends State<EditorJSView> {
  Future<void>? launched;
  late EditorJSData dataObject;

  @override
  void initState() {
    super.initState();

    dataObject = EditorJSData.fromJson(jsonDecode(widget.editorJSData!));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[];
    items.clear();
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
          levelHeight = 1.4;
          break;
        case 2:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineLarge!.fontSize!);
          levelColor = const Color.fromRGBO(60, 105, 220, 1);
          levelHeight = 1.4;
          break;
        case 3:
          levelFontSize =
              FontSize(Theme.of(context).textTheme.headlineMedium!.fontSize!);
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
            extensions: [
              TagExtension(
                tagsToExtend: {"br"},
                child: const SizedBox(height: 0),
              ),
            ],
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
              "code": Style(
                  fontFamily: "Montserrat",
                  backgroundColor: const Color.fromRGBO(197, 227, 255, 1),
                  fontWeight: FontWeight.w600),
              "mark": Style(
                  backgroundColor: const Color.fromRGBO(218, 200, 239, 1),
                  fontWeight: FontWeight.w600),
            },
          ));
          break;
        case "paragraph":
          items.add(Html(
            data: element.data!.text,
            extensions: [
              TagExtension(
                tagsToExtend: {"br"},
                child: const SizedBox(height: 0),
              ),
            ],
            style: {
              "body": Style(
                  margin: Margins.only(left: 0, top: 0, right: 0, bottom: 15)),
              "code": Style(
                  fontFamily: "Montserrat",
                  backgroundColor: const Color.fromRGBO(197, 227, 255, 1),
                  fontWeight: FontWeight.w700),
              "mark": Style(
                  backgroundColor: const Color.fromRGBO(218, 200, 239, 1),
                  fontWeight: FontWeight.w700),
              "a": Style(
                color: const Color.fromRGBO(60, 105, 220, 1),
                fontWeight: FontWeight.w700,
                textDecoration: TextDecoration.none,
              ),
            },
            onLinkTap: (url, _, __) => setState(() {
              launched = launchInBrowser(Uri.parse(url!));
            }),
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
                      extensions: [
                        TagExtension(
                          tagsToExtend: {"br"},
                          child: const SizedBox(height: 0),
                        ),
                      ],
                      style: {
                        "body": Style(margin: Margins.zero),
                        "a": Style(
                          color: const Color.fromRGBO(60, 105, 220, 1),
                          fontWeight: FontWeight.w700,
                          textDecoration: TextDecoration.none,
                        ),
                      },
                      onLinkTap: (url, _, __) => setState(() {
                        launched = launchInBrowser(Uri.parse(url!));
                      }),
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
                        extensions: [
                          TagExtension(
                            tagsToExtend: {"br"},
                            child: const SizedBox(height: 0),
                          ),
                        ],
                        style: {
                          "body": Style(margin: Margins.zero),
                          "a": Style(
                            color: const Color.fromRGBO(60, 105, 220, 1),
                            fontWeight: FontWeight.w700,
                            textDecoration: TextDecoration.none,
                          ),
                        },
                        onLinkTap: (url, _, __) => setState(() {
                          launched = launchInBrowser(Uri.parse(url!));
                        }),
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
              child: Image.network(
                  '${globals.url}${element.data!.file!.url!}?format=webp&width=800&embed'),
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
