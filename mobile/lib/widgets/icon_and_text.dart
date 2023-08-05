import 'package:flutter/material.dart';
import 'small_text.dart';
import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({super.key, required this.icon, required this.text, required this.iconColor});

  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconsize24,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(text: text, color: Colors.black)
      ],
    );
  }
}
