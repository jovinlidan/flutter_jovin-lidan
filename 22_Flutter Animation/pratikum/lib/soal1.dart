import 'package:flutter/material.dart';

class Soal1 extends StatefulWidget {
  const Soal1({Key? key}) : super(key: key);

  @override
  State<Soal1> createState() => _Soal1State();
}

class _Soal1State extends State<Soal1> {
  bool isBig = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Kotak Ajaib"),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () => setState(() => isBig = !isBig),
            child: AnimatedContainer(
              width: isBig ? 250 : 150,
              height: isBig ? 250 : 150,
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                  "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
