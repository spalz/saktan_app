import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/pages/settings/view/view.dart';

class GuidesListPage extends StatefulWidget {
  const GuidesListPage({Key? key}) : super(key: key);

  @override
  State<GuidesListPage> createState() => GuidesListPageState();
}

class GuidesListPageState extends State<GuidesListPage> {
  bool _isLoadRunning = false;
  List<GuidesList> _categories = <GuidesList>[];

  void _firstLoad() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
    //
    setState(() {
      _isLoadRunning = false;
    });

    final fetchedGuidesList = await fetchGuidesList();
    setState(() {
      _categories = fetchedGuidesList;
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
    var theme = Theme.of(context);
    const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
    const String settingsIconSvg = 'assets/images/icons/action_settings.svg';
    final Widget saktanLogo = SvgPicture.asset(saktanLogoSvg,
        width: 100,
        alignment: Alignment.topLeft,
        // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: 'Saktan');
    final Widget settingsIcon = SvgPicture.asset(settingsIconSvg, width: 28);
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 23,
          leading: Container(),
          leadingWidth: 0,
          title: saktanLogo,
          centerTitle: false,
          scrolledUnderElevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      settings: const RouteSettings(name: '/settings'),
                      builder: (context) => const SettingsPage()));
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: settingsIcon,
                )),
          ],
          actionsIconTheme: IconThemeData(
            color: theme.primaryColor,
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _isLoadRunning
              ? Container(
                  alignment: Alignment.topCenter,
                  child: const LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(90, 220, 190, 1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(240, 244, 255, 1),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        S.of(context).guide_title,
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
    );
  }
}
