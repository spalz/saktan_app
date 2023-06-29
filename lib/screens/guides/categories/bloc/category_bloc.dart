import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/globals.dart' as global;
import 'package:saktan_app/screens/guides/categories/categories.dart';
import 'package:stream_transform/stream_transform.dart';

part 'category_event.dart';
part 'category_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }

      final posts = await _fetchPosts(state.posts.length);

      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    try {
      final response = await httpClient.get(
        Uri.https(
          global.urlApi,
          'api/saktan-guides',
          <String, String>{
            'populate[icon][fields][0]': 'url',
            'fields': 'title__ru',
            // ignore: equal_keys_in_map
            'fields': 'title__ky',
            // ignore: equal_keys_in_map
            'fields': 'icon',
            'pagination[start]': '$startIndex',
            'pagination[limit]': '$_postLimit',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final dataList = responseBody['data'] as List;
        return dataList.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          final iconMap = map['icon'] as Map<String, dynamic>;
          return Post(
            id: map['id'] as int,
            slug: map['slug'] as String,
            titleRu: map['title__ru'] as String,
            titleKy: map['title__ky'] as String,
            icon: '${global.url}${iconMap['url']}',
          );
        }).toList();
      } else {}
    } catch (error) {
      throw Exception('Error fetching posts');
    }

    throw Exception('Error fetching posts');
  }
}
