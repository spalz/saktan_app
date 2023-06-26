import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

import 'about_health_chapters_screen.dart';

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
    final theme = Theme.of(context);

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
      bottomNavigationBar: const BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Text('О здоровье'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore),
                  Text('Помощь'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  Text('Новости'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Render the title widget for the first item
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Text(
                        'Справочник по репродуктивному и сексуальному здоровью',
                        style: theme.textTheme.bodyLarge,
                      ),
                    );
                  }

                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.grey[200],
                        focusColor: Colors.blue[200],
                        splashColor: Colors.blue[200],
                        minVerticalPadding: 22,
                        leading: Image.asset(
                          'assets/images/temp/health.png',
                          width: 38,
                        ),
                        title: Text(
                          "Секс и сексуальность",
                          style: theme.textTheme.titleSmall,
                        ),
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AboutHealthChapters(slug: "slug")));
                        },
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
