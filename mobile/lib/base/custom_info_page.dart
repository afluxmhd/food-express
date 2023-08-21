import 'package:flutter/material.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/utils/colors.dart';
import 'package:food_express/widgets/app_icon.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:food_express/widgets/small_text.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class CustomInfoPage extends StatelessWidget {
  const CustomInfoPage(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.descriptionOne,
      this.onPressedMain,
      this.descriptionTwo,
      this.onPressedSecondary,
      required this.appBarTitle});

  final String imagePath;
  final String title;
  final String appBarTitle;
  final String descriptionOne;
  final String? descriptionTwo;
  final void Function()? onPressedMain;
  final void Function()? onPressedSecondary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: 120),
                BigText(
                  text: appBarTitle,
                  fontWeight: FontWeight.w500,
                  size: 22,
                )
              ],
            ),
            Center(
              child: Container(
                height: 300,
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
            ),
            const SizedBox(height: 20),
            BigText(
              text: descriptionTwo ?? " ",
              size: 16,
            ),
            const SizedBox(height: 100),
            onPressedSecondary == null
                ? const SizedBox()
                : GestureDetector(
                    onTap: onPressedSecondary,
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 30),
                          BigText(
                            text: 'Cancel Order',
                            fontWeight: FontWeight.w400,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 15),
            onPressedMain == null
                ? const SizedBox()
                : GestureDetector(
                    onTap: onPressedMain,
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.mainColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 30),
                          BigText(
                            text: 'Go to Order Details',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
