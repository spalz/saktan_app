import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../editorjs/widgets/view.dart';

class AboutHealthDetailScreen extends StatefulWidget {
  final int initialIndex; //поле для хранения индекса
  final String slug; //поле для хранения индекса

  const AboutHealthDetailScreen(
      {Key? key, required this.initialIndex, required this.slug})
      : super(key: key);

  @override
  State<AboutHealthDetailScreen> createState() =>
      _AboutHealthDetailScreenState();
}

class _AboutHealthDetailScreenState extends State<AboutHealthDetailScreen> {
  late ItemScrollController _scrollController;
  EditorJSView? editorJSView;
  Map<int, GlobalKey> itemKeys = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();
    fetchTestData();
  }

  Future<void> fetchTestData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("data/editorjsdatatest.json");

    setState(() {
      editorJSView = EditorJSView(editorJSData: data);
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(widget.initialIndex);
    });
  }

  void _scrollToIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.isAttached) {
        _scrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastEaseInToSlowEaseOut,
          alignment: 0.0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Секс и сексуальность'),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white), // add this line
        titleTextStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: SelectionArea(
        child: ScrollablePositionedList.builder(
          itemCount: 10,
          itemScrollController: _scrollController,
          itemBuilder: (context, index) {
            final GlobalKey itemKey = GlobalKey();
            itemKeys[index] = itemKey;

            if (index == 0) {
              // Render the title widget for the first item
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    editorJSView ?? const Text("Please wait..."),
                  ],
                ),
              );
            }

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
                          '$index. Презервативы как метод тройной защиты',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              content: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                child: editorJSView ?? const Text("Please wait..."),
              ),
            );
          },
        ),
      ),
    );
  }
}
