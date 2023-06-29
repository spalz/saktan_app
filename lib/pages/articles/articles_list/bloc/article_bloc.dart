import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/globals.dart' as global;
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';
import 'package:stream_transform/stream_transform.dart';

part 'article_event.dart';
part 'article_state.dart';

const _articleLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required this.httpClient}) : super(const ArticleState()) {
    on<ArticleFetched>(
      _onArticleFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onArticleFetched(
    ArticleFetched event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      print("await _fetchArticles(): ${await _fetchArticles()}");

      if (state.status == ArticleStatus.initial) {
        final articles = await _fetchArticles();
        return emit(
          state.copyWith(
            status: ArticleStatus.success,
            articles: articles,
            hasReachedMax: false,
          ),
        );
      }
      final articles = await _fetchArticles(state.article.length);
      articles.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ArticleStatus.success,
                articles: List.of(state.article)..addAll(articles),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ArticleStatus.failure));
    }
  }

  Future<List<Article>> _fetchArticles([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        global.urlApi,
        'api/articles',
        <String, String>{
          'sort': 'published:desc',
          'populate[image][fields][0]': 'url',
          'fields[0]': 'slug',
          'fields[1]': 'title',
          'fields[2]': 'published',
          'locale': 'ru',
          'pagination[start]': '$startIndex',
          'pagination[limit]': '$_articleLimit',
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final dataList = responseBody['data'] as List;
      return dataList.map((dynamic json) {
        // print('dataList: $dataList');
        final map = json as Map<String, dynamic>;
        final imageMap = map['image'] as Map<String, dynamic>;
        return Article(
          id: map['id'] as int,
          slug: map['slug'] as String,
          published: map['published'] as String,
          title: map['title'] as String,
          image: '${global.url}${imageMap['url']}?format=webp&width=300&embed',
        );
      }).toList();
    }
    throw Exception('Error fetching articles');
  }
}
