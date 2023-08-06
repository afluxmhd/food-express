import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({super.key, required this.text, required this.price, required this.rating});

  final String text;
  final String price;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: text,
              fontWeight: FontWeight.w500,
              color: AppColors.mainBlackColor,
              size: Dimensions.font26,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width15, right: Dimensions.width15),
              decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius15)),
              child: BigText(text: '\$$price', size: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  rating.toInt(),
                  (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )),
            ),
            const SizedBox(
              width: 20,
            ),
            SmallText(
              text: rating.toString(),
              color: AppColors.mainBlackColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const SmallText(
              text: "1285",
              color: AppColors.mainBlackColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const SmallText(
              text: "comments",
              color: AppColors.mainBlackColor,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.iconColor2),
            IconAndTextWidget(icon: Icons.access_time_rounded, text: "32 min", iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
