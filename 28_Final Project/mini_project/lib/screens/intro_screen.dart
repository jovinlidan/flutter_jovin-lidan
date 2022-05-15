import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mini_project/styles/intro_screen.styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Selamat Datang",
        description:
            "Kembangkan kemampuan dan keahlianmu menjadi seorang profesional di bidang Teknologi sekarang juga disini",
        pathImage: "assets/images/intro1.png",
        backgroundColor: Colors.white,
        styleTitle: IntroScreenStyles.styleTitle,
        styleDescription: IntroScreenStyles.styleDescription,
      ),
    );
    slides.add(
      Slide(
        title: "Materi Terbaru",
        description:
            "Dapatkan seluruh materi terbaru hanya disini tanpa perlu mengeluarkan biaya sedikitpun",
        pathImage: "assets/images/intro2.png",
        backgroundColor: Colors.white,
        styleTitle: IntroScreenStyles.styleTitle,
        styleDescription: IntroScreenStyles.styleDescription,
      ),
    );
    slides.add(
      Slide(
        title: "Ayo Mulai",
        description: "Sudah tidak sabar? Tunggu apa lagi, ayo mulai belajar sekarang juga",
        pathImage: "assets/images/intro3.png",
        backgroundColor: Colors.white,
        styleTitle: IntroScreenStyles.styleTitle,
        styleDescription: IntroScreenStyles.styleDescription,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        nextButtonKey: const ValueKey('next_button_key'),
        doneButtonKey: const ValueKey('done_button_key'),
        slides: slides,
        onDonePress: onDonePress,
        nextButtonStyle: IntroScreenStyles.nextButton,
        doneButtonStyle: IntroScreenStyles.nextButton,
        colorDot: Colors.grey,
        colorActiveDot: Colors.blue,
        renderSkipBtn: Text(
          "Skip",
          style: IntroScreenStyles.skipText,
        ),
      ),
    );
  }
}
