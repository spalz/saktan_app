import 'package:equatable/equatable.dart';

class ContactCategoryList extends Equatable {
  const ContactCategoryList({
    required this.id,
    required this.slug,
    required this.published,
    required this.titleRu,
    required this.titleKy,
    required this.descriptionRu,
    required this.descriptionKy,
  });

  final int id;
  final String slug;
  final String published;
  final String titleRu;
  final String titleKy;
  final String descriptionRu;
  final String descriptionKy;

  @override
  List<Object?> get props => [
        id,
        slug,
        published,
        titleRu,
        titleKy,
        descriptionRu,
        descriptionKy,
      ];
}
