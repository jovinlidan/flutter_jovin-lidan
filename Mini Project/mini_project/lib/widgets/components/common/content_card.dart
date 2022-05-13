import 'package:flutter/material.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/model/content_model.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final Function() onTap;
  bool selected;
  ContentCard({Key? key, required this.content, required this.selected, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: CustomColors.primary4, width: selected ? 0 : 1),
        ),
        selected: selected,
        title: Text("${content.title}",
            style: TextStyle(
                color: selected ? Colors.white : Colors.white54, fontWeight: FontWeight.bold)),
        subtitle: Text("${content.duration}",
            style: TextStyle(color: selected ? Colors.white : Colors.white54)),
        tileColor: CustomColors.primary1,
        selectedTileColor: Colors.blue[900],
      ),
    );
  }
}
