import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/pages/help/help.dart';

Future<List<ContactList>> fetchContacts(String slug) async {
  try {
    final res = await getContactsRequest(slug);
    final fetchedCategories = json.decode(res.body)['data'] as List<dynamic>;
    return fetchedCategories.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return ContactList(
        id: map['id'] as int,
        slug: map['slug'] as String,
        published: map['published'] as String,
        titleRu: map['title__ru'] as String,
        titleKy: map['title__ky'] as String,
        addressRu: map['address__ru'] as String,
        addressKy: map['address__ky'] as String,
        addressCoordinates: map['address_coordinates'] as String?,
        descriptionRu: map['description__ru'] as String?,
        descriptionKy: map['description__ky'] as String?,
        region: map['region'] as String,
        email: map['email'] as String?,
        // phones:
      );
    }).toList();
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    return [];
  }
}

Future<http.Response> getContactsRequest(String slug) {
  final url = "${Uri.parse("$baseUrl/api/saktan-contacts")}";
  final params = {
    'sort': 'published:desc',
    'fields[0]': 'slug',
    'fields[1]': 'published',
    'fields[2]': 'title__ru',
    'fields[3]': 'title__ky',
    'fields[4]': 'address__ru',
    'fields[5]': 'address__ky',
    'fields[6]': 'address_coordinates',
    'fields[7]': 'description__ru',
    'fields[8]': 'description__ky',
    'fields[9]': 'region',
    'fields[10]': 'email',
    'pagination[page]': '1',
    'pagination[pageSize]': '50',
    'filters[category][slug][\$eq]': slug,
  };
  final uri = Uri.parse(url).replace(queryParameters: params);
  return http.get(uri);
}

// &filters[category][slug][0][$eq]=overnment-centers-and-hospitals
// filters[category][slug][$eq]=government-centers-and-hospitals