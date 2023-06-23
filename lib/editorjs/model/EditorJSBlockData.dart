import './EditorJSBlockFile.dart';

class EditorJSBlockData {
  final String? text;
  final int? level;
  final String? style;
  final List<String>? items;
  final EditorJSBlockFile? file;
  final String? caption;
  final String? source;
  final bool? withBorder;
  final bool? stretched;
  final bool? withBackground;

  EditorJSBlockData(
      {this.text,
      this.level,
      this.style,
      this.items,
      this.file,
      this.caption,
      this.source,
      this.withBorder,
      this.stretched,
      this.withBackground});

  factory EditorJSBlockData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List?;
    final List<String> itemsList = <String>[];

    if (list != null) {
      for (var element in list) {
        itemsList.add(element);
      }
    }

    return EditorJSBlockData(
        text: parsedJson['text'],
        level: parsedJson['level'],
        style: parsedJson['style'],
        items: itemsList,
        file: (parsedJson['file'] != null)
            ? EditorJSBlockFile.fromJson(parsedJson['file'])
            : null,
        caption: parsedJson['caption'],
        source: parsedJson['source'],
        withBorder: parsedJson['withBorder'],
        withBackground: parsedJson['withBackground']);
  }
}
