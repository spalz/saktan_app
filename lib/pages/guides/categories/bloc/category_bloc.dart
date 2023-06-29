import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/globals.dart' as global;
import 'package:saktan_app/pages/guides/categories/categories.dart';
import 'package:stream_transform/stream_transform.dart';

part 'category_event.dart';
part 'category_state.dart';

const _categoryLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.httpClient}) : super(const CategoryState()) {
    on<CategoryFetched>(
      _onCategoryFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onCategoryFetched(
    CategoryFetched event,
    Emitter<CategoryState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CategoryStatus.initial) {
        final categories = await _fetchCategories();
        return emit(
          state.copyWith(
            status: CategoryStatus.success,
            categories: categories,
            hasReachedMax: false,
          ),
        );
      }
      final categoeies = await _fetchCategories(state.category.length);
      categoeies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: CategoryStatus.success,
                categories: List.of(state.category)..addAll(categoeies),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: CategoryStatus.failure));
    }
  }

  Future<List<Category>> _fetchCategories([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        global.urlApi,
        'api/saktan-guides',
        <String, String>{
          'populate[icon][fields][0]': 'url',
          'fields[0]': 'title__ru',
          'fields[1]': 'title__ky',
          'fields[2]': 'icon',
          'fields[3]': 'slug',
          'pagination[start]': '$startIndex',
          'pagination[limit]': '$_categoryLimit',
        },
      ),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final dataList = responseBody['data'] as List;
      return dataList.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        final iconMap = map['icon'] as Map<String, dynamic>;
        return Category(
          id: map['id'] as int,
          slug: map['slug'] as String,
          titleRu: map['title__ru'] as String,
          titleKy: map['title__ky'] as String,
          icon: '${global.url}${iconMap['url']}',
        );
      }).toList();
    }
    throw Exception('Error fetching categories');
  }
}
