import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key, required this.pageId, required this.page});

  final int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              //background image
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.popularFoodImgSize,
                  decoration:
                      const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage("asset/shawarma.png"))),
                ),
              ),
              //icon widgets
              Positioned(
                top: Dimensions.height20,
                left: Dimensions.width10 * 1.2,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page == 'cartpage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios_new_outlined),
                    ),
                  ],
                ),
              ),
              //introduction of food
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularFoodImgSize - 20,
                child: Container(
                    padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            Dimensions.radius20,
                          ),
                          topLeft: Radius.circular(Dimensions.radius20)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(
                          text: product.name,
                          price: product.price.toString(),
                          rating: product.rating,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        BigText(text: "Introduce"),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ExpandableTextWidget(text: product.description),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
          //Navigation bar cart
          bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProductController) {
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
                      GestureDetector(
                        onTap: () {
                          popularProductController.setQuantity(false);
                        },
                        child: const Icon(Icons.remove, color: AppColors.signColor),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: popularProductController.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                        child: const Icon(Icons.add, color: AppColors.signColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProductController.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration:
                        BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                    child: BigText(
                      text: "    Add to Cart     ",
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
            );
          })),
    );
  }
}
