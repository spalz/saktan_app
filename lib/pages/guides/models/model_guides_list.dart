import 'package:equatable/equatable.dart';

final class GuidesList extends Equatable {
  const GuidesList({
    required this.id,
    required this.slug,
    required this.published,
    required this.titleRu,
    required this.titleKy,
    required this.icon,
  });

  final int id;
  final String slug;
  final String published;
  final String titleRu;
  final String titleKy;
  final String icon;

  @override
  List<Object> get props => [id, slug, published, titleRu, titleKy, icon];
}
