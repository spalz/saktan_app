import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/utils/utils.dart';

class ArticlesListPage extends StatefulWidget {
  const ArticlesListPage({Key? key}) : super(key: key);

  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  String _currentLanguage = Intl.getCurrentLocale();
  int _page = 1;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<Article> _posts = <Article>[];

  Future<void> _firstLoad() async {
    final fetchedPosts =
        await fetchArticlesList(_page, _limit, _currentLanguage);
    if (mounted) {
      setState(() {
        _posts = fetchedPosts;
        _isFirstLoadRunning = false;
      });
    }
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

      final fetchedPosts =
          await fetchArticlesList(_page, _limit, _currentLanguage);
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

  Future<void> _handleRefresh() async {
    setState(() {
      _posts.clear();
      _isFirstLoadRunning = true;
      _page = 1;
      _currentLanguage = Intl.getCurrentLocale();
    });

    await _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(logo: "indigo", centerTitle: false),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isFirstLoadRunning
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
      ),
    );
  }
}
