import 'package:flutter/material.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/utils/dimensions.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/small_text.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.height10 * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: 'My Orders',
                    size: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              recognizer: null,
                              text: "Current",
                              style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16))),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
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
                  onTap: () {},
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
                ),
              )
            ],
          ),
          //History card
          SizedBox(height: Dimensions.height20),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "12-02-2022 16:00:23",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: Dimensions.height10 - 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(2, (index) {
                                return Container(
                                  height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                    color: AppColors.mainColor,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  BigText(text: "4 Items"),
                                  GestureDetector(
                                    onTap: () {
                                      print("Add to Cart");
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                          border: Border.all(width: 1, color: AppColors.mainColor),
                                        ),
                                        child: const SmallText(
                                          text: "On the way",
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
