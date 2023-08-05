import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.fontWeight = FontWeight.w400,
      this.size = 0,
      this.overFlow = TextOverflow.ellipsis});

  final Color? color;
  final String text;
  final double size;
  final FontWeight fontWeight;
  TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style:
          TextStyle(color: color, fontWeight: fontWeight, fontSize: size == 0 ? Dimensions.font20 : size, fontFamily: 'Roboto'),
    );
  }
}
