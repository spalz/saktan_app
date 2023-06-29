part of 'category_bloc.dart';

enum CategoryStatus { initial, success, failure }

final class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.initial,
    this.category = const <Category>[],
    this.hasReachedMax = false,
  });

  final CategoryStatus status;
  final List<Category> category;
  final bool hasReachedMax;

  CategoryState copyWith({
    CategoryStatus? status,
    List<Category>? categories,
    bool? hasReachedMax,
  }) {
    return CategoryState(
      status: status ?? this.status,
      category: categories ?? category,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''CategoryState { status: $status, hasReachedMax: $hasReachedMax, categories: ${category.length} }''';
  }

  @override
  List<Object> get props => [status, category, hasReachedMax];
}
