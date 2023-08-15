import 'package:flutter/material.dart';

import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

class ItemEmptyPage extends StatelessWidget {
  ItemEmptyPage({super.key, required this.title, required this.descriptionOne, this.imagePath});

  String? imagePath;
  final String title;
  final String descriptionOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: imagePath != null ? 130 : 200),
      child: Column(
        children: [
          imagePath != null
              ? Center(
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    )),
                    child: null,
                  ),
                )
              : const Center(child: SizedBox()),
          const SizedBox(height: 30),
          BigText(
            text: title,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 300,
            child: SmallText(
              text: descriptionOne,
              size: 15,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
