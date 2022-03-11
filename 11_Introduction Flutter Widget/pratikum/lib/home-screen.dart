import 'package:flutter/material.dart';
import 'package:flutter_app/time-widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: const [
            TimeWidget(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
