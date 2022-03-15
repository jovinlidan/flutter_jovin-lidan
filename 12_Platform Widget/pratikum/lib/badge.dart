import "package:flutter/material.dart";

class CustomBadges extends StatelessWidget {
  final Color color;
  final double size;
  final Widget child;
  final Widget? parent;
  const CustomBadges(
      {Key? key, this.color = Colors.black, this.size = 20, required this.child, this.parent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (parent != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          parent!,
          Positioned(
            top: -(size / 4),
            right: -(size / 4),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(child: child),
            ),
          )
        ],
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(child: child),
    );
  }
}
