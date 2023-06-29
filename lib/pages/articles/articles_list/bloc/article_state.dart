part of 'article_bloc.dart';

enum ArticleStatus { initial, success, failure }

final class ArticleState extends Equatable {
  const ArticleState({
    this.status = ArticleStatus.initial,
    this.article = const <Article>[],
    this.hasReachedMax = false,
  });

  final ArticleStatus status;
  final List<Article> article;
  final bool hasReachedMax;

  ArticleState copyWith({
    ArticleStatus? status,
    List<Article>? articles,
    bool? hasReachedMax,
  }) {
    return ArticleState(
      status: status ?? this.status,
      article: articles ?? article,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ArticleState { status: $status, hasReachedMax: $hasReachedMax, articles: ${article.length} }''';
  }

  @override
  List<Object> get props => [status, article, hasReachedMax];
}
