import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/editorjs/widgets/view.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GuideDetailPage extends StatefulWidget {
  final int chapterIndex;
  final GuideDetail guide;

  const GuideDetailPage(
      {Key? key, required this.chapterIndex, required this.guide})
      : super(key: key);

  @override
  State<GuideDetailPage> createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  late ItemScrollController _scrollController;
  EditorJSView? editorJSView;
  Map<int, GlobalKey> itemKeys = {};
  late final GuideDetail _guide = widget.guide;

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
      _scrollToIndex(widget.chapterIndex);
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
    final locale = Intl.getCurrentLocale();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: getT(locale, _guide.titleRu, _guide.titleKy),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: Colors.white,
        centerTitle: true,
        settings: false,
      ),
      body: SelectionArea(
        child: ScrollablePositionedList.builder(
          itemCount: _guide.chapters.length,
          itemScrollController: _scrollController,
          itemBuilder: (context, index) {
            final GlobalKey itemKey = GlobalKey();
            itemKeys[index] = itemKey;

            // if (index == 0) {
            //   // Render the title widget for the first item
            //   return Container(
            //     padding: const EdgeInsets.all(20),
            //     child: Column(
            //       children: [
            //         AspectRatio(
            //           aspectRatio: 1.0,
            //           child: SizedBox(
            //             width: double.infinity,
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(20),
            //                 color: Colors.grey[100],
            //                 border: Border.all(
            //                   color: Colors.grey.shade200,
            //                 ),
            //               ),
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(20),
            //                 child: Image.network(
            //                   '${_guide.image}?format=webp&width=800&embed',
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         editorJSView ?? const Text("Please wait..."),
            //       ],
            //     ),
            //   );
            // }

            return GuidesDetailChaptersListItem(
                itemKey: itemKey,
                index: index,
                chapter: _guide.chapters[index]);
          },
        ),
      ),
    );
  }
}
