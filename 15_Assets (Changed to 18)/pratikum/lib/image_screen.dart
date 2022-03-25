import 'package:flutter/material.dart';

class ImageScreenProps {
  final String uri;

  ImageScreenProps({required this.uri});
}

class ImageScreen extends StatelessWidget {
  static const imageScreenName = "/images";

  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ImageScreenProps;
    return Scaffold(
      appBar: AppBar(title: const Text("Images")),
      body: Hero(
        child: Image.network(
          args.uri,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        tag: args.uri,
      ),
    );
  }
}
