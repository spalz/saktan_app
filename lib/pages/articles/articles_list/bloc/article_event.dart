part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ArticleFetched extends ArticleEvent {}
