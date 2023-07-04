import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/utils/utils.dart';

Future<List<Article>> fetchArticlesList(int page, int limit) async {
  try {
    final res = await getArticlesListRequest(page, limit);
    final fetchedPosts = res.data['data'] as List<dynamic>;
    return fetchedPosts.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      final imageMap = map['image'] as Map<String, dynamic>;
      return Article(
        id: map['id'] as int,
        slug: map['slug'] as String,
        published: map['published'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        image: '$baseUrl${imageMap['url']}',
      );
    }).toList();
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    return [];
  }
}

Future<Response<dynamic>> getArticlesListRequest(int page, int limit) async {
  final url = "${Uri.parse("$baseUrl/api/articles")}";
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

  final dio = Dio();
  final response = await dio.getUri(uri);
  return response;
}
