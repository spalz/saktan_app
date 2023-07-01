import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

Future<List<ContactCategoryList>> fetchContactsCategories() async {
  try {
    final res = await getContactsCategoriesRequest();
    final fetchedCategories = json.decode(res.body)['data'] as List<dynamic>;
    return fetchedCategories.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return ContactCategoryList(
        id: map['id'] as int,
        slug: map['slug'] as String,
        published: map['published'] as String,
        titleRu: map['title__ru'] as String,
        titleKy: map['title__ky'] as String,
        descriptionRu: map['description__ru'] as String,
        descriptionKy: map['description__ky'] as String,
      );
    }).toList();
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    return [];
  }
}

Future<http.Response> getContactsCategoriesRequest() {
  final url = "${Uri.parse("$baseUrl/api/saktan-contacts-categories")}";
  final params = {
    'sort': 'published:desc',
    'fields[0]': 'slug',
    'fields[1]': 'published',
    'fields[2]': 'title__ru',
    'fields[3]': 'title__ky',
    'fields[4]': 'description__ru',
    'fields[5]': 'description__ky',
    'pagination[page]': '1',
    'pagination[pageSize]': '50',
  };
  final uri = Uri.parse(url).replace(queryParameters: params);
  return http.get(uri);
}
