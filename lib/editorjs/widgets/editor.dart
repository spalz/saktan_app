import 'package:flutter/material.dart';

import './components/textcomponent.dart';
import './toolbar.dart';

class EditorJSEditor extends StatefulWidget {
  const EditorJSEditor({Key? key}) : super(key: key);

  @override
  EditorJSEditorState createState() => EditorJSEditorState();
}

class EditorJSEditorState extends State<EditorJSEditor> with ChangeNotifier {
  final List<Widget> items = <Widget>[];

  @override
  void initState() {
    super.initState();

    setState(() {
      items.add(Row(children: [TextComponent.addText()]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: items,
          ),
        ),
        EditorJSToolbar(parent: this)
      ],
    );
  }
}
