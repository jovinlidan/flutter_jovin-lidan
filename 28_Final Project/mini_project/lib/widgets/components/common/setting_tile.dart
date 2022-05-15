import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  const SettingTile({Key? key, required this.text, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromARGB(255, 17, 75, 223), width: 1.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          title: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
