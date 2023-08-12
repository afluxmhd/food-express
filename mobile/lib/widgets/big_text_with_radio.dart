import 'package:flutter/material.dart';
import 'package:food_express/widgets/big_text.dart';

class BigTextWithCheckWidget extends StatelessWidget {
  const BigTextWithCheckWidget({super.key, required this.bigText, required this.groupValue, required this.onChanged});

  final BigText bigText;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Radio(value: bigText.text, groupValue: groupValue, onChanged: onChanged),
          bigText,
        ],
      ),
    );
  }
}
