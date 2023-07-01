import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/utils/utils.dart';

Future<ArticleDetail> fetchArticleDetail(String slug) async {
  try {
    final res = await _getArticleDetailRequest(slug);
    final fetchedPost = res.data['data'];

    final map = fetchedPost as Map<String, dynamic>;
    final imageMap = map['image'] as Map<String, dynamic>?;

    return ArticleDetail(
      id: map['id'] as int,
      slug: map['slug'] as String,
      published: map['published'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      image: '$baseUrl${imageMap!['url']}',
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

Future<Response<dynamic>> _getArticleDetailRequest(String slug) {
  final url = "${Uri.parse("$baseUrl/api/slugify/slugs/article/$slug")}";
  final params = {
    'populate[image][fields][0]': 'url',
    'locale': 'ru',
  };
  final dio = Dio();
  return dio.get(url, queryParameters: params);
}
