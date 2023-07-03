import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/articles/view/articles_list_page.dart';
import 'package:saktan_app/pages/guides/view/guides_list_page.dart';
import 'package:saktan_app/pages/help/view/contact_categories_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      CachedScreen(
        screenIndex: 0,
        currentIndex: _currentIndex,
        child: const GuidesListPage(),
      ),
      CachedScreen(
        screenIndex: 1,
        currentIndex: _currentIndex,
        child: const ContactCategoriesPage(),
      ),
      CachedScreen(
        screenIndex: 2,
        currentIndex: _currentIndex,
        child: const ArticlesListPage(),
      ),
    ];

    const String navigationGuidesSvg =
        'assets/images/icons/navigation_guides.svg';
    const String navigationHelpSvg = 'assets/images/icons/navigation_help.svg';
    const String navigationArticlesSvg =
        'assets/images/icons/navigation_articles.svg';

    final Widget navigationGuides = SvgPicture.asset(
      navigationGuidesSvg,
      width: 28,
      colorFilter: ColorFilter.mode(
        _currentIndex == 0 ? Colors.black : Colors.black54,
        BlendMode.srcIn,
      ),
    );
    final Widget navigationHelp = SvgPicture.asset(
      navigationHelpSvg,
      width: 28,
      colorFilter: ColorFilter.mode(
        _currentIndex == 1 ? Colors.black : Colors.black54,
        BlendMode.srcIn,
      ),
    );
    final Widget navigationArticles = SvgPicture.asset(
      navigationArticlesSvg,
      width: 28,
      colorFilter: ColorFilter.mode(
        _currentIndex == 2 ? Colors.black : Colors.black54,
        BlendMode.srcIn,
      ),
    );

    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.7),
          selectedFontSize: 15,
          unselectedFontSize: 15,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          currentIndex: _currentIndex,
          elevation: 0,
          // onTap: onTap,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: navigationGuides,
              activeIcon: navigationGuides,
              label: S.of(context).navigationGuides,
            ),
            BottomNavigationBarItem(
              icon: navigationHelp,
              activeIcon: navigationHelp,
              label: S.of(context).navigationHelp,
            ),
            BottomNavigationBarItem(
              icon: navigationArticles,
              activeIcon: navigationArticles,
              label: S.of(context).navigationArticles,
            ),
          ],
        ));
  }
}

class CachedScreen extends StatefulWidget {
  final int screenIndex;
  final int currentIndex;
  final Widget child;

  const CachedScreen(
      {super.key,
      required this.screenIndex,
      required this.currentIndex,
      required this.child});

  @override
  _CachedScreenState createState() => _CachedScreenState();
}

class _CachedScreenState extends State<CachedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return IgnorePointer(
      ignoring: widget.screenIndex != widget.currentIndex,
      child: PageStorage(
        bucket: PageStorageBucket(),
        child: widget.child,
      ),
    );
  }
}
