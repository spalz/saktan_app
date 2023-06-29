import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    _controller.dispose(); // Освобождаем ресурсы
    super.dispose();
  }

  void _fetchArticles() async {
    try {
      final res = await http.get(Uri.parse(
          "${Uri.parse("$_baseUrl/api/articles?sort=published:desc&populate[image][fields][0]=url&fields[0]=slug&fields[1]=title&fields[2]=published&locale=ru&pagination[page]=$_page&pagination[pageSize]=$_limit")}"));

      final fetchedPosts = json.decode(res.body)['data'] as List<dynamic>;

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
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong!');
      }
    }

    setState(() {
      if (_isFirstLoadRunning) {
        _isFirstLoadRunning = false;
      } else if (_isLoadMoreRunning) {
        _isLoadMoreRunning = false;
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
