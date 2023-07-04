import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

Future<List<UsefulLinksList>> fetchUsefulLinks() async {
  try {
    final res = await getUsefulLinksRequest();
    final fetchedCategories = res.data['data'] as List<dynamic>;
    return fetchedCategories.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      final usefulLinks = map['useful_link'] as List<dynamic>;
      final List<UsefulLink> links = usefulLinks.map((dynamic linkJson) {
        final linkMap = linkJson as Map<String, dynamic>;
        return UsefulLink(
          id: linkMap['id'] as int,
          title: linkMap['title'] as String,
          sourceName: linkMap['sourse_name'] as String,
          link: linkMap['link'] as String,
        );
      }).toList();

      return UsefulLinksList(
        id: map['id'] as int,
        slug: map['slug'] as String,
        titleRu: map['title__ru'] as String,
        titleKy: map['title__ky'] as String,
        usefulLinks: links,
      );
    }).toList();
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    return [];
  }
}

Future<Response<dynamic>> getUsefulLinksRequest() async {
  final url = "${Uri.parse("$baseUrl/api/saktan-guides")}";
  final params = {
    'sort': 'published:desc',
    'fields[0]': 'slug',
    'fields[1]': 'title__ru',
    'fields[2]': 'title__ky',
    'populate': 'useful_link',
    'pagination[page]': '1',
    'pagination[pageSize]': '99',
  };
  final uri = Uri.parse(url).replace(queryParameters: params);
  final dio = Dio();
  return dio.getUri(uri);
}
