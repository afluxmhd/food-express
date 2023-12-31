import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText(
      {super.key,
      this.color = const Color(0xFF89dad0),
      required this.text,
      this.size = 12,
      this.height = 1.2,
      this.textAlign = TextAlign.start});

  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: size,
          fontFamily: 'Roboto',
        ),
        textAlign: textAlign);
  }
}
