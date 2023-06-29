import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/guides/categories/categories.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state.status) {
          case CategoryStatus.failure:
            return const Center(child: Text('Ошибка загрузки записей'));
          case CategoryStatus.success:
            if (state.category.isEmpty) {
              return const Center(child: Text('Нет категорий'));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: Text(
                      S.of(context).guide_title,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.category.length
                          ? Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const BottomLoader())
                          : Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: CategoryListItem(
                                  category: state.category[index]),
                            );
                    },
                    itemCount: state.hasReachedMax
                        ? state.category.length
                        : state.category.length + 1,
                    controller: _scrollController,
                  ),
                ],
              ),
            );
          case CategoryStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CategoryBloc>().add(CategoryFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
