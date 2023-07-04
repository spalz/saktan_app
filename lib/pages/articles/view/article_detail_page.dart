import 'package:flutter/material.dart';
import 'package:saktan_app/editorjs/editorjs.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/utils/app_bar.dart';

class ArticleDetailPage extends StatefulWidget {
  final String slug;
  final String title;
  const ArticleDetailPage({Key? key, required this.slug, required this.title})
      : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool _isLoadRunning = true;
  ArticleDetail? _post;

  late final String _slug = widget.slug;

  void _firstLoad() async {
    try {
      setState(() {
        _isLoadRunning = true;
      });

      final fetchedPost = await fetchArticleDetail(_slug);
      setState(() {
        _post = fetchedPost;
        _isLoadRunning = false;
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
      appBar: CustomAppBar(
        title: widget.title,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(170, 125, 220, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: Colors.white,
        settings: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SelectionArea(
            child: _isLoadRunning
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
                          const SizedBox(height: 80),
                        ],
                      )
                    : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
