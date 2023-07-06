import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saktan_app/pages/settings/settings.dart';
import 'package:saktan_app/utils/utils.dart';

Future<SettingsAbout> fetchSettingsAbout() async {
  try {
    final res = await _getSettingsAboutRequest();
    final fetchedPost = res.data['data'];

    final map = fetchedPost as Map<String, dynamic>;

    return SettingsAbout(
      id: map['id'] as int,
      slug: map['slug'] as String,
      titleRu: map['title__ru'] as String,
      titleKy: map['title__ky'] as String,
      bodyRu: map['body__ru'] as String? ?? '',
      bodyKy: map['body__ky'] as String? ?? '',
    );
  } catch (err) {
    if (kDebugMode) {
      print('Something went wrong $err');
    }
    rethrow;
  }
}

Future<Response<dynamic>> _getSettingsAboutRequest() {
  final url = "${Uri.parse("$baseUrl/api/slugify/slugs/page/saktan-about")}";
  final dio = Dio();
  return dio.get(url);
}
