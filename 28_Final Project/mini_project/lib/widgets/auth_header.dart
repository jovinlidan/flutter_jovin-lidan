import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String desc1;
  final String desc2;
  const AuthHeader({Key? key, required this.title, required this.desc1, required this.desc2})
      : super(key: key);

  final TextStyle descriptionTextStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/auth_header.png"),
            fit: BoxFit.cover,
          ),
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      // decoration: BoxDecoration(
      //   color: Colors.blue[900],
      // ),
      height: 280,
      width: double.infinity,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  letterSpacing: 2,
                ),
              ),
              left: 40,
              top: 20,
            ),
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    desc1,
                    style: descriptionTextStyle,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc2,
                    style: descriptionTextStyle,
                  ),
                ],
              ),
              right: 30,
              bottom: 20,
            )
          ],
        ),
      ),
    );
  }
}
