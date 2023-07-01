import 'package:equatable/equatable.dart';

class UsefulLinksList extends Equatable {
  const UsefulLinksList({
    required this.id,
    required this.slug,
    required this.titleRu,
    required this.titleKy,
    required this.usefulLinks,
  });

  final int id;
  final String slug;
  final String titleRu;
  final String titleKy;
  final List<UsefulLink> usefulLinks;

  @override
  List<Object?> get props => [
        id,
        slug,
        titleRu,
        titleKy,
        usefulLinks,
      ];
}

class UsefulLink {
  const UsefulLink({
    required this.id,
    required this.title,
    required this.sourceName,
    required this.link,
  });

  final int id;
  final String title;
  final String sourceName;
  final String link;
}
