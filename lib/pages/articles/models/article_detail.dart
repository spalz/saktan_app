import 'package:equatable/equatable.dart';

class ArticleDetail extends Equatable {
  const ArticleDetail({
    required this.id,
    required this.slug,
    required this.published,
    required this.title,
    required this.description,
    required this.image,
    required this.bodyRu,
    required this.bodyKy,
    // required this.files,
    required this.locale,
  });

  final int id;
  final String slug;
  final String published;
  final String title;
  final String description;
  final String image;
  final String bodyRu;
  final String bodyKy;
  // final String files;
  final String locale;

  @override
  List<Object?> get props => [
        id,
        slug,
        published,
        title,
        description,
        image,
        bodyRu,
        bodyKy,
        // files,
        locale
      ];
}
