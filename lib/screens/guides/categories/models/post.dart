import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post(
      {required this.id,
      required this.titleRu,
      required this.titleKy,
      required this.descriptionRu,
      required this.descriptionKy,
      required this.icon,
      required this.slug});

  final int id;
  final String titleRu;
  final String titleKy;
  final String descriptionRu;
  final String descriptionKy;
  final String icon;
  final String slug;

  @override
  List<Object> get props =>
      [id, titleRu, titleKy, descriptionRu, descriptionKy, icon, slug];
}
