import 'package:equatable/equatable.dart';

class GuideDetail extends Equatable {
  const GuideDetail({
    required this.id,
    required this.slug,
    required this.published,
    required this.titleRu,
    required this.titleKy,
    required this.descriptionRu,
    required this.descriptionKy,
    required this.chapters,
  });

  final int id;
  final String slug;
  final String published;
  final String titleRu;
  final String titleKy;
  final String descriptionRu;
  final String descriptionKy;
  final List<Chapter> chapters;

  @override
  List<Object?> get props => [
        id,
        slug,
        titleRu,
        titleKy,
        descriptionRu,
        descriptionKy,
      ];
}

class Chapter {
  const Chapter({
    required this.id,
    required this.titleRu,
    required this.titleKy,
    required this.bodyRu,
    required this.bodyKy,
  });

  final int id;
  final String titleRu;
  final String titleKy;
  final String bodyRu;
  final String bodyKy;
}
