import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:saktan_app/screens/guides/categories/categories.dart';
import 'package:saktan_app/screens/help/help.dart';
import 'package:saktan_app/screens/news/news.dart';

class AboutHealthScreen extends StatefulWidget {
  const AboutHealthScreen({super.key});

  @override
  State<AboutHealthScreen> createState() => _AboutHealthScreenState();
}

class _AboutHealthScreenState extends State<AboutHealthScreen> {
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
                          builder: (context) => const AboutHealthScreen()));
                    },
                    child: const Icon(Icons.home),
                  ),
                  const Text('О здоровье'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HelpScreen()));
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
                          builder: (context) => const NewsList()));
                    },
                    child: const Icon(Icons.person),
                  ),
                  const Text('Новости'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
