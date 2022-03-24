import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  const LabelWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          height: 0.5,
        ),
      ),
    );
  }
}
