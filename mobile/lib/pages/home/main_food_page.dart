import 'package:flutter/material.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatelessWidget {
  const MainFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: Column(
        children: [
          SizedBox(height: Dimensions.height10 * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: 'Deliver to',
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        'New York, USA',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: AppColors.mainBlackColor,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius15), color: AppColors.mainColor),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: Dimensions.iconsize24,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: Dimensions.height10),
          const Expanded(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}
