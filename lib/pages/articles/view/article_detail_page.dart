import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saktan_app/editorjs/editorjs.dart';
import 'package:saktan_app/globals.dart' as global;
import 'package:saktan_app/pages/articles/articles.dart';

class ArticleDetailPage extends StatefulWidget {
  final String slug;
  const ArticleDetailPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _baseUrl = global.urlApi;

  bool _isFirstLoadRunning = true;
  ArticleDetail? _post;

  late final String _slug = widget.slug;

  Future<ArticleDetail> _fetchArticles() async {
    try {
      final res = await _getArticlesRequest();
      final fetchedPost = res.data['data'];

      final map = fetchedPost as Map<String, dynamic>;
      final imageMap = map['image'] as Map<String, dynamic>?;

      return ArticleDetail(
        id: map['id'] as int,
        slug: map['slug'] as String,
        published: map['published'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        image: '${global.url}${imageMap!['url']}',
        bodyRu: map['body__ru'] as String? ?? '',
        bodyKy: map['body__ky'] as String? ?? '',
        locale: map['locale'] as String,
      );
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong $err');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> _getArticlesRequest() {
    final url = "${Uri.parse("$_baseUrl/api/slugify/slugs/article/$_slug")}";
    final params = {
      'populate[image][fields][0]': 'url',
      'locale': 'ru',
    };
    final dio = Dio();
    return dio.get(url, queryParameters: params);
  }

  void _firstLoad() async {
    try {
      setState(() {
        _isFirstLoadRunning = true; // Set the flag to true before loading
      });

      final fetchedPost = await _fetchArticles();
      setState(() {
        _post = fetchedPost;
        _isFirstLoadRunning = false;
      });
    } catch (err) {
      // Handle the error, show an error message, etc.
    }
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(170, 125, 220, 1),
        iconTheme: const IconThemeData(color: Colors.white), // add this line
        titleSpacing: 10,
        title: _post != null
            ? Text(
                _post!.title,
              )
            : const Text("Загрузка..."),
        // centerTitle: false,
        scrolledUnderElevation: 1,
        titleTextStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SelectionArea(
            child: _isFirstLoadRunning
                ? const ArticleDetailTtemSkeleton()
                : _post != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[100],
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '${_post?.image}?format=webp&width=800&embed',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _post!.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: const Color.fromRGBO(170, 125, 220, 1),
                              fontFamily: textTheme.headlineLarge!.fontFamily,
                              fontSize: textTheme.headlineLarge!.fontSize,
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(_post!.description),
                          EditorJSView(editorJSData: _post!.bodyRu),
                        ],
                      )
                    : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
