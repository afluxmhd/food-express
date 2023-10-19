import 'package:flutter/material.dart';
import 'package:food_express/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class PromoCardWidget extends StatelessWidget {
  const PromoCardWidget({super.key, required this.code, required this.description, this.onTap, required this.isApplied});

  final String code;
  final String description;
  final void Function()? onTap;
  final bool isApplied;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                  border: Border.all(width: 1, color: AppColors.mainColor),
                ),
                child: BigText(
                  text: code,
                  fontWeight: FontWeight.w500,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  onTap: onTap,
                  child: SmallText(
                    text: isApplied ? 'Coupon Applied' : 'Apply',
                    color: isApplied ? AppColors.mainColor : Colors.grey,
                  ))
            ],
          ),
          SmallText(text: description)
        ],
      ),
    );
  }
}
