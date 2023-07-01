import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/generated/l10n.dart';
import 'package:saktan_app/pages/articles/articles.dart';
import 'package:saktan_app/pages/guides/categories/categories.dart';
import 'package:saktan_app/pages/help/help.dart';
import 'package:saktan_app/pages/settings/view/settings_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // todo: uncommented it
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    const String saktanLogoSvg = 'assets/images/logo/saktan.svg';
    final Widget saktanLogo = SvgPicture.asset(saktanLogoSvg,
        width: 100,
        alignment: Alignment.topLeft,
        // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: 'Saktan');
    return Scaffold(
      appBar: AppBar(
        title: saktanLogo,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CategoriesPage()));
                    },
                    child: const Icon(Icons.home),
                  ),
                  Text(S.of(context).bottomNavigationBarGuides),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactCategoryPage()));
                    },
                    child: const Icon(Icons.explore),
                  ),
                  const Text('Помощь'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ArticlesPage()));
                    },
                    child: const Icon(Icons.new_label),
                  ),
                  const Text('Новости'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            CategoryBloc(httpClient: http.Client())..add(CategoryFetched()),
        child: const CategoriesList(),
      ),
    );
  }
}
