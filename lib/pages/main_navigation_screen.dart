import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/articles/view/articles_list_page.dart';
import 'package:saktan_app/pages/guides/view/guides_list_page.dart';
import 'package:saktan_app/pages/help/view/contact_categories_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

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

    final Widget navigationGuides = Column(
      children: [
        SvgPicture.asset(
          navigationGuidesSvg,
          width: 30,
          colorFilter: ColorFilter.mode(
            _currentIndex == 0
                ? Theme.of(context).primaryColor
                : Colors.black87,
            BlendMode.srcIn,
          ),
        ),
        Text(
          S.of(context).navigationGuides,
          style: TextStyle(
            color: _currentIndex == 0
                ? Theme.of(context).primaryColor
                : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
    final Widget navigationHelp = Column(
      children: [
        SvgPicture.asset(
          navigationHelpSvg,
          width: 30,
          colorFilter: ColorFilter.mode(
            _currentIndex == 1
                ? Theme.of(context).primaryColor
                : Colors.black87,
            BlendMode.srcIn,
          ),
        ),
        Text(
          S.of(context).navigationHelp,
          style: TextStyle(
            color: _currentIndex == 1
                ? Theme.of(context).primaryColor
                : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
    final Widget navigationArticles = Column(
      children: [
        SvgPicture.asset(
          navigationArticlesSvg,
          width: 30,
          colorFilter: ColorFilter.mode(
            _currentIndex == 2
                ? Theme.of(context).primaryColor
                : Colors.black87,
            BlendMode.srcIn,
          ),
        ),
        Text(
          S.of(context).navigationArticles,
          style: TextStyle(
            color: _currentIndex == 2
                ? Theme.of(context).primaryColor
                : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(199, 199, 199, 0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.only(top: 8),
          color: Colors.white,
          elevation: 0,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 110,
                  child: IconButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    icon: navigationGuides,
                    splashRadius: 5,
                    onPressed: () {
                      _onTabTapped(0);
                    },
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: IconButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    icon: navigationHelp,
                    splashRadius: 5,
                    onPressed: () {
                      _onTabTapped(1);
                    },
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: IconButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    icon: navigationArticles,
                    onPressed: () {
                      _onTabTapped(2);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CachedScreen extends StatefulWidget {
  final int screenIndex;
  final int currentIndex;
  final Widget child;

  const CachedScreen({
    Key? key,
    required this.screenIndex,
    required this.currentIndex,
    required this.child,
  }) : super(key: key);

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
