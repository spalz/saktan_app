import 'package:equatable/equatable.dart';

class SettingsAbout extends Equatable {
  const SettingsAbout({
    required this.id,
    required this.slug,
    required this.titleRu,
    required this.titleKy,
    required this.bodyRu,
    required this.bodyKy,
  });

  final int id;
  final String slug;
  final String titleRu;
  final String titleKy;
  final String bodyRu;
  final String bodyKy;

  @override
  List<Object?> get props => [id, slug, titleRu, titleKy, bodyRu, bodyKy];
}
