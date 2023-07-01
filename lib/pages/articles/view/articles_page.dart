import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/globals.dart' as global;
import 'package:saktan_app/pages/articles/articles.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final _baseUrl = global.urlApi;

  int _page = 1;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<Article> _posts = <Article>[];

  Future<List<Article>> _fetchArticles() async {
    try {
      final res = await _getArticlesRequest(_page, _limit);
      final fetchedPosts = json.decode(res.body)['data'] as List<dynamic>;
      return fetchedPosts.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        final imageMap = map['image'] as Map<String, dynamic>;
        return Article(
          id: map['id'] as int,
          slug: map['slug'] as String,
          published: map['published'] as String,
          title: map['title'] as String,
          description: map['description'] as String,
          image: '${global.url}${imageMap['url']}',
        );
      }).toList();
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong $err');
      }
      return [];
    }
  }

  Future<http.Response> _getArticlesRequest(int page, int limit) {
    final url = "${Uri.parse("$_baseUrl/api/articles")}";
    final params = {
      'sort': 'published:desc',
      'filters[for_saktan][\$eq]': 'true',
      'populate[image][fields][0]': 'url',
      'fields[0]': 'slug',
      'fields[1]': 'title',
      'fields[2]': 'published',
      'fields[3]': 'description',
      'locale': 'ru',
      'pagination[page]': page.toString(),
      'pagination[pageSize]': limit.toString(),
    };
    final uri = Uri.parse(url).replace(queryParameters: params);
    return http.get(uri);
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final fetchedPosts = await _fetchArticles();
    setState(() {
      _posts = fetchedPosts;
    });

    setState(() {
      _isFirstLoadRunning = false;
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

      final fetchedPosts = await _fetchArticles();
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
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => index == 0
                        ? ArticleListItemFirst(article: _posts[index])
                        : ArticleListItem(article: _posts[index]),
                  ),
                ),

                // if (_isLoadMoreRunning) const ArticleListTtemSkeleton(),
              ],
            ),
    );
  }
}
