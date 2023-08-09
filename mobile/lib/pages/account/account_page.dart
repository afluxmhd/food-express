import 'package:flutter/material.dart';
import 'package:food_express/controller/auth_controller.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/widgets/accounts_widget.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    void logoutUser() {
      Get.find<AuthController>().logoutUser();
      Get.toNamed(RouteHelper.getSignInPage());
    }

    return Padding(
        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width20, top: Dimensions.height20 * 2),
        child: GetBuilder<AuthController>(builder: (authController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  AppIcon(
                      icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height20 * 4,
                      size: Dimensions.height20 * 6),
                  SizedBox(width: Dimensions.width30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.height10),
                      BigText(
                        text: 'Mohammed Aflah',
                        fontWeight: FontWeight.w500,
                        size: 20,
                      ),
                      BigText(
                        text: 'aflumogral7@gmail.com',
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getEditProfilePage());
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 3.5,
                          height: Dimensions.screenHeight / 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Edit Profile",
                              fontWeight: FontWeight.w500,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20 * 1.5),
              //Body
              AccountWidget(
                icon: Icons.location_on_outlined,
                bigText: BigText(text: 'Change Address'),
                onPressed: () {
                  Get.toNamed(RouteHelper.getLocationPage());
                },
              ),
              const Divider(),
              SizedBox(height: Dimensions.height20),
              AccountWidget(
                icon: Icons.notifications_off_outlined,
                bigText: BigText(text: 'Turn off Alert'),
                switchButton: true,
                switchValue: true,
              ),
              AccountWidget(
                icon: Icons.clear_all,
                bigText: BigText(text: 'Clear Notifcations'),
                onPressed: () {
                  print('Clear Notification');
                },
              ),
              AccountWidget(
                icon: Icons.history_outlined,
                bigText: BigText(text: 'Clear History'),
                onPressed: () {
                  print('Clear History');
                },
              ),
              const Divider(),
              SizedBox(height: Dimensions.height20),

              AccountWidget(
                icon: Icons.call_made_outlined,
                bigText: BigText(text: 'Support'),
                onPressed: () {
                  print('Support');
                },
              ),
              AccountWidget(
                icon: Icons.logout_outlined,
                bigText: BigText(text: 'Logout', color: Colors.red),
                onPressed: () {
                  logoutUser();
                },
              ),
            ],
          );
        }));
  }
}
