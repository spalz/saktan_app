import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class UsefulLinksPage extends StatefulWidget {
  const UsefulLinksPage({Key? key}) : super(key: key);

  @override
  State<UsefulLinksPage> createState() => _UsefulLinksPageState();
}

class _UsefulLinksPageState extends State<UsefulLinksPage> {
  bool _isLoadRunning = false;
  List<UsefulLinksList> _links = <UsefulLinksList>[];
  Future<void>? launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _firstLoad() async {
    setState(() {
      _isLoadRunning = true;
    });

    final fetchedLinks = await fetchUsefulLinks();
    setState(() {
      _links = fetchedLinks;
    });

    setState(() {
      _isLoadRunning = false;
    });
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
    if (kDebugMode) {
      print("locale: ${Intl.getCurrentLocale()}");
    }
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).usefullLinksTitle,
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: Colors.white,
        settings: false,
      ),
      body: DefaultTabController(
        length: _links.length,
        child: Column(
          children: <Widget>[
            if (_isLoadRunning)
              const LinearProgressIndicator(
                backgroundColor: Color.fromRGBO(222, 248, 242, 1),
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(240, 244, 255, 1)),
              ), // Лоадер вместо CircularProgressIndicator
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelStyle: const TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    isScrollable: true,
                    tabs: _links.map((link) {
                      return Tab(
                        height: 56,
                        text: link.titleRu,
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: _links.map((link) {
                        return GridView.extent(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 80),
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: List.generate(
                              link.usefulLinks.length,
                              (index) {
                                final usefulLink = link.usefulLinks[index];

                                return GestureDetector(
                                  onTap: () => setState(() {
                                    launched = _launchInBrowser(
                                        Uri.parse(usefulLink.link));
                                  }),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(
                                          240, 244, 255, 1),
                                    ),
                                    child: Flex(
                                      direction: Axis.vertical,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          usefulLink.title,
                                          maxLines: 4,
                                          maxFontSize: 18,
                                          wrapWords: true,
                                          style: TextStyle(
                                            fontSize: theme.textTheme
                                                .titleSmall!.fontSize!,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          usefulLink.sourceName,
                                          style: TextStyle(
                                            fontSize: theme.textTheme
                                                .labelSmall!.fontSize!,
                                            color: theme.primaryColor,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
