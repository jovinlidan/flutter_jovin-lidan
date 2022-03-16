import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class Soal1 extends StatelessWidget {
  const Soal1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("Badges")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              toAnimate: false,
              shape: BadgeShape.square,
              badgeColor: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              badgeContent: const Text('BADGE', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 10,
            ),
            Badge(
              toAnimate: false,
              shape: BadgeShape.square,
              badgeColor: Colors.deepPurple,
              borderRadius: BorderRadius.circular(8),
              badgeContent: const Text('BADGE', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ));
  }
}
