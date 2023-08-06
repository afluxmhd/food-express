import 'package:flutter/material.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height20 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial(0));
                  },
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 6),
                BigText(
                  text: 'My Cart',
                  size: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainBlackColor,
                )
              ],
            ),
            GetBuilder<CartController>(builder: (cartController) {
              var _cartList = cartController.getItems;
              return Expanded(
                  child: cartController.items.isNotEmpty
                      ? ListView.builder(
                          itemCount: cartController.items.length,
                          itemBuilder: (_, index) {
                            return SizedBox(
                              height: Dimensions.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      width: Dimensions.height20 * 5,
                                      height: Dimensions.height20 * 5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              fit: BoxFit.cover, image: AssetImage("asset/indian_chicken_biriryani.jpg")),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: SizedBox(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: _cartList[index].name!, color: Colors.black54),
                                          const SmallText(text: "Cart Product"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: '\$${_cartList[index].price}', color: Colors.black54),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: const Icon(Icons.remove, color: AppColors.signColor),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.width10 / 2,
                                                    ),
                                                    BigText(text: _cartList[index].quantity.toString()),
                                                    SizedBox(
                                                      width: Dimensions.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: const Icon(Icons.add, color: AppColors.signColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          child: Center(child: BigText(text: 'No Item')),
                        ));
            })
          ],
        ),
      ),
      //bottom nav bar contains total price and checkout
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.bottomheightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height20, bottom: Dimensions.width20, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2), topRight: Radius.circular(Dimensions.radius20 * 2))),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20), color: Colors.white),
              child: Row(
                children: [
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(text: '\$${cartController.totalAmount}'),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: BigText(
                  text: "Check Out",
                  color: Colors.white,
                ),
              ),
            )
          ]),
        );
      }),
    );
  }
}
