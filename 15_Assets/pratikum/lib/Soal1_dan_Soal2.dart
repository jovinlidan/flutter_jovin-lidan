import 'package:flutter/material.dart';
import 'package:pratikum/image_screen.dart';

class Soal1danSoal2 extends StatelessWidget {
  const Soal1danSoal2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>
            Scaffold(appBar: AppBar(title: const Text("Assets")), body: const CustomGridView()),
        ImageScreen.imageScreenName: (context) => const ImageScreen()
      },
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({Key? key}) : super(key: key);

  final List<String> datas = const [
    'https://i.scdn.co/image/ab6761610000e5eb006ff3c0136a71bfb9928d34',
    'https://awsimages.detik.net.id/community/media/visual/2021/03/09/iu-comeback-dengan-lilac_43.jpeg?w=700&q=90',
    'https://cdn0-production-images-kly.akamaized.net/RJLVAGFYIdVNsWTDOazXMlFODak=/1x24:702x419/469x260/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/2284563/original/053190300_1531929684-2.jpg',
    'https://media.suara.com/pictures/970x544/2020/05/08/70693-iuinstagram.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GridView.count(
        crossAxisCount: 2,
        children: datas.map((data) => CustomGridCard(uri: data)).toList(),
      ),
    );
  }
}

class CustomGridCard extends StatelessWidget {
  final String uri;
  const CustomGridCard({Key? key, required this.uri}) : super(key: key);

  void onNavigateImageScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      ImageScreen.imageScreenName,
      arguments: ImageScreenProps(uri: uri),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Hero(
          child: Image.network(uri, fit: BoxFit.cover),
          tag: uri,
        ),
      ),
      onTap: () => onNavigateImageScreen(context),
    );
  }
}
