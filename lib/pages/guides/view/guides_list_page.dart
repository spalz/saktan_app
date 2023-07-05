import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

class GuidesListPage extends StatefulWidget {
  const GuidesListPage({Key? key}) : super(key: key);

  @override
  State<GuidesListPage> createState() => GuidesListPageState();
}

class GuidesListPageState extends State<GuidesListPage> {
  bool _isLoadRunning = true;
  List<GuidesList> _categories = <GuidesList>[];

  Future<void> _fetchGuidesList() async {
    final fetchedGuidesList = await fetchGuidesList();

    if (mounted) {
      setState(() {
        _categories = fetchedGuidesList;
        _isLoadRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  void _firstLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();

    await _fetchGuidesList();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoadRunning = true;
    });

    await _fetchGuidesList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(logo: "saktan", centerTitle: false),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isLoadRunning
            ? const GuidesListSkeleton()
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          S.of(context).guideTitle,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _categories.length,
                        itemBuilder: (_, index) =>
                            GuidesListItem(guide: _categories[index]),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
