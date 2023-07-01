import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/utils/utils.dart';

Future<ContactDetail> fetchContactDetail(int id) async {
  try {
    final res = await getContactDetailRequest(id);
    final fetchedCategories = res.data['data'];

    final map = fetchedCategories as Map<String, dynamic>;

    final contactPhones = map['phones'] as List<dynamic>;
    final List<ContactPhone> phones = contactPhones.map((dynamic linkJson) {
      final linkMap = linkJson as Map<String, dynamic>;
      return ContactPhone(
        id: linkMap['id'] as int,
        phone: linkMap['phone'] as String,
        name: linkMap['name'] as String?,
      );
    }).toList();

    return ContactDetail(
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
      phones: phones,
    );
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    rethrow;
  }
}

Future<Response<dynamic>> getContactDetailRequest(int id) {
  final url = "${Uri.parse("$baseUrl/api/saktan-contacts/$id")}";
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
    'populate': 'phones',
  };
  final dio = Dio();
  return dio.get(url, queryParameters: params);
}
