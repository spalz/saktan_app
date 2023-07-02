import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/pages/articles/articles.dart';

class ArticlesListPage extends StatefulWidget {
  const ArticlesListPage({Key? key}) : super(key: key);

  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  int _page = 1;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<Article> _posts = <Article>[];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final fetchedPosts = await fetchArticlesList(_page, _limit);
    setState(() {
      _posts = fetchedPosts;
    });

    setState(() {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isFirstLoadRunning = false;
        });
      });
    });
  }

  void _loadMore() async {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
        _page += 1;
      });

      final fetchedPosts = await fetchArticlesList(_page, _limit);
      if (fetchedPosts.isNotEmpty) {
        setState(() {
          _posts.addAll(fetchedPosts);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String indigoLogoSvg = 'assets/images/logo/indigo.svg';
    final Widget indigoLogo = SvgPicture.asset(
      indigoLogoSvg,
      width: 100,
      alignment: Alignment.topLeft,
      semanticsLabel: 'Indigo',
    );
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 23,
        leading: Container(),
        leadingWidth: 0,
        title: indigoLogo,
        centerTitle: false,
        scrolledUnderElevation: 1,
      ),
      body: _isFirstLoadRunning
          ? const ArticleListTtemSkeleton()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => index == 0
                        ? ArticleListItemFirst(article: _posts[index])
                        : ArticleListItem(article: _posts[index]),
                  ),
                ),
              ],
            ),
    );
  }
}
