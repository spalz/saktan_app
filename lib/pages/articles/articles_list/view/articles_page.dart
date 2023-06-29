import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saktan_app/globals.dart' as global;

import '../models/article.dart';
import '../widgets/article_list_item.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final _baseUrl = global.urlApi;

  int _page = 0;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  final List<Article> _posts = <Article>[];
  late ScrollController _controller;
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
    _dio =
        Dio(BaseOptions(baseUrl: _baseUrl)); // Инициализация Dio с базовым URL
    _firstLoad();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    _controller.dispose();
    _dio.close();
    super.dispose();
  }

  void _fetchArticles() {
    setState(() {
      if (_isFirstLoadRunning) {
        _isFirstLoadRunning = false;
      } else if (_isLoadMoreRunning) {
        _isLoadMoreRunning = false;
      }
    });

    final url = "$_baseUrl/api/articles";
    final params = {
      'sort': 'published:desc',
      'populate[image][fields][0]': 'url',
      'fields[0]': 'slug',
      'fields[1]': 'title',
      'fields[2]': 'description',
      'fields[3]': 'published',
      'locale': 'ru',
      'pagination[page]': _page.toString(),
      'pagination[pageSize]': _limit.toString(),
    };

    _dio.get(url, queryParameters: params).then((response) {
      final fetchedPosts = response.data['data'] as List<dynamic>;

      List<Article> addPosts = fetchedPosts.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        final imageMap = map['image'] as Map<String, dynamic>;
        return Article(
          id: map['id'] as int,
          slug: map['slug'] as String,
          published: map['published'] as String,
          title: map['title'] as String,
          image: '${global.url}${imageMap['url']}?format=webp&width=300&embed',
        );
      }).toList();

      if (addPosts.isNotEmpty) {
        setState(() {
          _posts.addAll(addPosts);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Something went wrong: $error');
      }
    });
  }

  void _firstLoad() {
    setState(() {
      _isFirstLoadRunning = true;
    });
    _fetchArticles();
  }

  void _loadMore() {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
        _page += 1;
      });
      _fetchArticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
    final Widget saktanLogo = SvgPicture.asset(
      saktanLogoSvg,
      width: 100,
      alignment: Alignment.topLeft,
      semanticsLabel: 'Saktan',
    );

    return Scaffold(
      appBar: AppBar(
        title: saktanLogo,
        centerTitle: false,
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) =>
                        ArticleListItem(article: _posts[index]),
                  ),
                ),
                if (_isLoadMoreRunning)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
    );
  }
}
