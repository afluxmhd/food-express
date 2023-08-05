import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                  decoration: const BoxDecoration(
                      image: DecorationImage(fit: BoxFit.cover, image: AssetImage("asset/indian_chicken_biriryani.jpg"))),
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
                          Get.toNamed(RouteHelper.getInitial(0));
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
                        const AppColumn(
                          text: "Chicken Biriyani",
                          price: "4.23",
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        BigText(text: "Introduce"),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        const Expanded(
                          child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text:
                                    "Chicken Biryani is a culinary masterpiece that tantalizes the taste buds with its exquisite blend of flavors and textures. This beloved dish features tender chunks of marinated chicken, slow-cooked to perfection, nestled among fragrant basmati rice, which is infused with a harmonious symphony of spices.The process of making Chicken Biryani involves meticulous layering, where partially cooked rice is alternated with the chicken and its accompanying gravy. The aromatic spices, such as cinnamon, cardamom, cloves, and bay leaves, impart their alluring fragrance, infusing the rice and chicken with a heavenly aroma"),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
          //Navigation bar cart
          bottomNavigationBar: Container(
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
                        //--
                      },
                      child: const Icon(Icons.remove, color: AppColors.signColor),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: '10'),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        //+
                      },
                      child: const Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //Tap
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  child: BigText(
                    text: "    Add to Cart     ",
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          )),
    );
  }
}

//  BigText(text: "\$23.22", size: 22, fontWeight: FontWeight.bold),
//                         SizedBox(
//                           height: Dimensions.height10,
//                         ),