import 'package:equatable/equatable.dart';

final class Article extends Equatable {
  const Article({
    required this.id,
    required this.slug,
    required this.published,
    required this.title,
    required this.image,
  });

  final int id;
  final String slug;
  final String published;
  final String title;
  final String image;

  @override
  List<Object> get props => [id, slug, published, title, image];
}
