import 'package:flutter/material.dart';

import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

class ItemEmptyPage extends StatelessWidget {
  const ItemEmptyPage({super.key, required this.imagePath, required this.title, required this.descriptionOne});

  final String imagePath;
  final String title;
  final String descriptionOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              )),
              child: null,
            ),
          ),
          const SizedBox(height: 30),
          BigText(
            text: title,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 5),
          SmallText(
            text: descriptionOne,
            size: 16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
