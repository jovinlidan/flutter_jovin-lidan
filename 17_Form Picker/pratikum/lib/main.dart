import 'package:flutter/material.dart';
import 'package:pratikum/create_post_screen.dart';
import 'package:pratikum/preview_post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const CreatePostScreen(),
        PreviewPostScreen.previewPostScreenName: (context) => const PreviewPostScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
