import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

class ChaptersListPage extends StatefulWidget {
  final int id;

  const ChaptersListPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ChaptersListPage> createState() => ChaptersListPageState();
}

class ChaptersListPageState extends State<ChaptersListPage> {
  bool _isLoadRunning = false;
  GuideDetail? _guide;

  late final int id = widget.id;

  void _firstLoad() async {
    try {
      setState(() {
        _isLoadRunning = true;
      });

      final fetchedPost = await fetchGuideDetail(id);
      setState(() {
        _guide = fetchedPost;
        _isLoadRunning = false;
      });
    } catch (err) {
      // Handle the error, show an error message, etc.
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _guide != null
              ? getT(locale, _guide!.titleRu, _guide!.titleKy)
              : "Загрузка...",
        ),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white), // add this line
        titleTextStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: ListView.builder(
            itemCount: _guide?.chapters.length ?? 0,
            itemBuilder: (context, index) {
              return GuidesChaptersListItem(
                  chapter: _guide!.chapters[index],
                  index: index,
                  guide: _guide!);
            }),
      ),
    );
  }
}
