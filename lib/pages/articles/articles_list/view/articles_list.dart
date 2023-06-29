import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/articles/articles_list/articles_list.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.failure:
            return const Center(child: Text('Ошибка загрузки записей'));
          case ArticleStatus.success:
            if (state.article.isEmpty) {
              return const Center(child: Text('Нет записей'));
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
                        left: 0, right: 0, top: 0, bottom: 80),
                    itemBuilder: (BuildContext context, int index) {
                      // print("index: $index");
                      // print("state.article.length: $state.article.length");
                      return index >= state.article.length
                          ? Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const BottomLoader())
                          : Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ArticleListItem(
                                  article: state.article[index]),
                            );
                    },
                    itemCount: state.hasReachedMax
                        ? state.article.length
                        : state.article.length + 1,
                    controller: _scrollController,
                  ),
                ],
              ),
            );
          case ArticleStatus.initial:
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
    if (_isBottom) context.read<ArticleBloc>().add(ArticleFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
