import 'package:flutter/material.dart';

class IntroScreenStyles {
  static const TextStyle styleTitle =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle styleDescription =
      TextStyle(color: Colors.black, fontSize: 15, height: 1.4);

  static TextStyle skipText =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

  static ButtonStyle nextButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
    ),
  );
}
