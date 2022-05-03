import 'package:flutter/material.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        Center(
          child: Text("Posts",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
