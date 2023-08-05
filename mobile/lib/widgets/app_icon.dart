import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
      {super.key,
      required this.icon,
      this.backgroundColor = Colors.transparent,
      this.iconColor = const Color(0xFF756d54),
      this.size = 40,
      this.iconSize = 22});

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2), color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
