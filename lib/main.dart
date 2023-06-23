import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './editorjs/widgets/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(60, 105, 220, 1),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(60, 105, 220, 1)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              titleSpacing: 20),
          useMaterial3: true,
          fontFamily: "Montserrat",
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 20.0,
            ),
            displayMedium: TextStyle(fontSize: 20.0),
            displaySmall: TextStyle(fontSize: 20.0),
            //
            headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            headlineMedium: TextStyle(
              fontSize: 24,
            ),
            headlineSmall: TextStyle(
              fontSize: 22,
            ),
            //
            titleLarge:
                TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
            titleMedium: TextStyle(fontSize: 20.0),
            titleSmall: TextStyle(fontSize: 20.0),
            //
            bodyLarge: TextStyle(
              fontSize: 20.0,
              color: Colors.cyan,
            ),
            bodyMedium: TextStyle(
              fontSize: 18,
            ),
            bodySmall: TextStyle(
              fontSize: 20.0,
            ),
            //
            labelLarge: TextStyle(fontSize: 20.0),
            labelMedium: TextStyle(fontSize: 20.0),
            labelSmall: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          )),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EditorJSView? editorJSView;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SelectionArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //
              //
              if (editorJSView != null)
                editorJSView!
              else
                const Text("Please wait..."),
              //
              //
              Text.rich(
                textAlign: TextAlign.left,
                selectionColor: Colors.red,
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "You have pushed the button this many times: ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '$_counter',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/1_c326f7c4a1.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/3_7adfa8b33b.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/4_9def2be50e.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/5_7f51acc7fd.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/6_55622603c8.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/6_55622603c8.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/7_301afb2913.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              CachedNetworkImage(
                width: 300,
                height: 300,
                imageUrl:
                    "https://admin.indigo.kg/uploads/8_1261efe342.jpg?format=webp&width=725&embed",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
