import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:saktan_app/pages/guides/guides.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // todo: uncommented it
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
    // set false first time
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const GuidesListPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('assets/images/on_boarding/$assetName', width: width);
  }

  Widget _titleWidget(Color color, String firstWord, String restOfText) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstWord,
            style: TextStyle(
              color: color,
              fontSize: 26.0,
              fontWeight: FontWeight.w900,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: restOfText,
            style: const TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w900,
              height: 1.4,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _bodyWidget(String text) {
    return Text.rich(
      TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      contentMargin: EdgeInsets.all(0),
      imagePadding: EdgeInsets.only(top: 100),
      titlePadding: EdgeInsets.fromLTRB(25, 30, 25, 15),
      bodyPadding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      pageColor: Colors.white,
      safeArea: 0,
      // bodyFlex: 0,
      // imageFlex: 2,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: false,
      autoScrollDuration: null,
      infiniteAutoScroll: false,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 90,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            child: const Text(
              'Начать',
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          useScrollView: false,
          titleWidget: _titleWidget(const Color.fromRGBO(60, 105, 220, 1),
              'Здоровье', ': ВИЧ, сексуальность, права'),
          bodyWidget: _bodyWidget(
              "Узнайте о важности здоровья, включая ВИЧ-инфекцию, различные аспекты сексуальности и ваши права в этой сфере."),
          image: _buildImage('image_01.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          useScrollView: false,
          titleWidget: _titleWidget(const Color.fromRGBO(60, 105, 220, 1),
              'Помощь', ': кризисные центры, ссылки'),
          bodyWidget: _bodyWidget(
              "В случае необходимости мы готовы предоставить вам помощь и поддержку. Обратитесь к нашим кризисным центрам и найдите полезные ссылки."),
          image: _buildImage('image_02.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          useScrollView: false,
          titleWidget: _titleWidget(const Color.fromRGBO(170, 125, 220, 1),
              'Новости', ': события и не только'),
          bodyWidget: _bodyWidget(
              "Будьте в курсе последних событий и новостей, связанных с движением ЛГБТ. От улучшения прав ЛГБТ-сообщества до важных моментов и достижений."),
          image: _buildImage('image_03.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      showDoneButton: false,
      //rtl: true, // Display as right-to-left
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}