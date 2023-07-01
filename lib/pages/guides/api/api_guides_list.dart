import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:saktan_app/utils/utils.dart';

Future<List<GuidesList>> fetchGuidesList(String slug) async {
  try {
    final res = await getGuidesListRequest(slug);
    final fetchedCategories = json.decode(res.body)['data'] as List<dynamic>;
    return fetchedCategories.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      final iconMap = map['image'] as Map<String, dynamic>;
      return GuidesList(
        id: map['id'] as int,
        slug: map['slug'] as String,
        published: map['published'] as String,
        titleRu: map['title__ru'] as String,
        titleKy: map['title__ky'] as String,
        icon: '$baseUrl${iconMap['url']}',
      );
    }).toList();
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    return [];
  }
}

Future<http.Response> getGuidesListRequest(String slug) {
  final url = "${Uri.parse("$baseUrl/api/saktan-guides")}";
  final params = {
    'sort': 'published:desc',
    'populate[icon][fields][0]': 'url',
    'fields[0]': 'title__ru',
    'fields[1]': 'title__ky',
    'fields[2]': 'icon',
    'fields[3]': 'slug',
    'pagination[page]': '1',
    'pagination[pageSize]': '50'
  };
  final uri = Uri.parse(url).replace(queryParameters: params);
  return http.get(uri);
}
