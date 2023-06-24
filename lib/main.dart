import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import './editorjs/widgets/view.dart';
import 'theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const SaktanApp());
}

class SaktanApp extends StatelessWidget {
  const SaktanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saktan',
      debugShowCheckedModeBanner: false,
      theme: whiteTheme,
      home: const AboutHealthScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class AboutHealthScreen extends StatefulWidget {
  const AboutHealthScreen({super.key, required this.title});
  final String title;

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
    // await Future.delayed(const Duration(seconds: 3));
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
              Icon(Icons.home),
              Icon(Icons.search),
              Icon(Icons.add),
              Icon(Icons.favorite),
              Icon(Icons.person),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Text(
              'Справочник по репродуктивному и сексуальному здоровью',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                itemCount: 4,
                itemBuilder: (context, index) {
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
                                  const AboutHealthChapters()));
                        },
                      ));
                }),
          ),
          //
          // if (editorJSView != null)
          //   editorJSView!
          // else
          //   const Text("Please wait..."),
        ],
      ),
    );
  }
}

class AboutHealthChapters extends StatelessWidget {
  const AboutHealthChapters({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите раздел'),
        iconTheme: IconThemeData(color: theme.primaryColor), // add this line
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Colors.grey[200],
                          focusColor: Colors.blue[200],
                          splashColor: Colors.blue[200],
                          minVerticalPadding: 10,
                          title: Text(
                            "${index + 1}. Секс и сексуальность",
                            style: theme.textTheme.bodyMedium,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const AboutHealthDetail()));
                          },
                        ));
                  }),
            ),
            //
            // if (editorJSView != null)
            //   editorJSView!
            // else
            //   const Text("Please wait..."),
          ],
        ),
      ),
    );
  }
}

class AboutHealthDetail extends StatefulWidget {
  const AboutHealthDetail({super.key});

  @override
  State<AboutHealthDetail> createState() => _AboutHealthDetailState();
}

class _AboutHealthDetailState extends State<AboutHealthDetail> {
  EditorJSView? editorJSView;

  @override
  void initState() {
    super.initState();
    fetchTestData();
  }

  void fetchTestData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("data/editorjsdatatest.json");
    String styles = await DefaultAssetBundle.of(context)
        .loadString("data/editorjsstyles.json");

    setState(() {
      editorJSView = EditorJSView(editorJSData: data, styles: styles);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Секс и сексуальность'),
        iconTheme: IconThemeData(color: theme.primaryColor), // add this line
      ),
      body: SelectionArea(
        child: ListView.builder(itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blueGrey[700],
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #$index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              child: editorJSView ?? const Text("Please wait..."),
            ),
          );
        }),
      ),
    );
  }
}
