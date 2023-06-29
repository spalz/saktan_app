import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post(
      {required this.id,
      required this.titleRu,
      required this.titleKy,
      required this.icon,
      required this.slug});

  final int id;
  final String titleRu;
  final String titleKy;
  final String icon;
  final String slug;

  @override
  List<Object> get props => [id, titleRu, titleKy, icon, slug];
}
