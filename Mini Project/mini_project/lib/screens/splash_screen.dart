import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                Icon(
                  Icons.code_rounded,
                  color: Colors.white,
                  size: 120,
                ),
              ],
            ),
            const Text("Code",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))
          ],
        ),
      ),
    );
  }
}
