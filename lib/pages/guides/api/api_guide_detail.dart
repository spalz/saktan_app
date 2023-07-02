import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

Future<GuideDetail> fetchGuideDetail(int id) async {
  try {
    final res = await getGuideDetailRequest(id);
    final fetchedCategories = res.data['data'];

    final map = fetchedCategories as Map<String, dynamic>;

    final guideChapters = map['chapters'] as List<dynamic>;
    final List<Chapter> chapters = guideChapters.map((dynamic linkJson) {
      final chapterMap = linkJson as Map<String, dynamic>;
      return Chapter(
        id: chapterMap['id'] as int,
        titleRu: chapterMap['title__ru'] as String,
        titleKy: chapterMap['title__ky'] as String,
        bodyRu: chapterMap['body__ru'] as String,
        bodyKy: chapterMap['body__ky'] as String,
      );
    }).toList();

    final imageMap = map['image'] as Map<String, dynamic>;
    return GuideDetail(
      id: map['id'] as int,
      slug: map['slug'] as String,
      published: map['published'] as String,
      image: '$baseUrl${imageMap['url']}',
      titleRu: map['title__ru'] as String,
      titleKy: map['title__ky'] as String,
      descriptionRu: map['description__ru'] as String,
      descriptionKy: map['description__ky'] as String,
      chapters: chapters,
    );
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    rethrow;
  }
}

Future<Response<dynamic>> getGuideDetailRequest(int id) {
  final url = "${Uri.parse("$baseUrl/api/saktan-guides/$id")}";
  final params = {
    'populate[image][fields][0]': 'url',
    'populate': 'chapters',
  };
  final dio = Dio();
  return dio.get(url, queryParameters: params);
}
