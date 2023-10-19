import 'package:flutter/material.dart';
import 'package:food_express/widgets/small_text.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallText(
            text: '  $title',
            size: 15,
            color: Colors.black45,
          ),
          SmallText(
            text: '\$$value',
            size: 15,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
