import 'package:flutter/material.dart';
import 'package:food_express/controller/auth_controller.dart';
import 'package:food_express/controller/notification_controller.dart';
import 'package:food_express/controller/user_controller.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/widgets/accounts_widget.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  void logoutUser() {
    Get.find<AuthController>().logoutUser();
    Get.offAndToNamed(RouteHelper.getSignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 15, top: 50),
        child: GetBuilder<UserController>(builder: (userController) {
          return userController.isloading
              ? const Center(child: CircularProgressIndicator())
              : Column(
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
                              text: userController.userModel.fullName,
                              fontWeight: FontWeight.w500,
                              size: 20,
                            ),
                            BigText(
                              text: userController.userModel.email,
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
                    GetBuilder<NotificationController>(builder: (notificationController) {
                      return SizedBox(
                        height: 50,
                        child: AccountWidget(
                          icon: Icons.notifications_off_outlined,
                          bigText: BigText(text: 'Turn off Notifications'),
                          switchButton: true,
                          switchValue: notificationController.isNotificationEnabled,
                          onPressedSwitchButton: (value) {
                            notificationController.changeNotificationAlert(value);
                          },
                        ),
                      );
                    }),
                    AccountWidget(
                      icon: Icons.clear_all,
                      bigText: BigText(text: 'Clear Notifcations'),
                      onPressed: () {
                        Get.find<NotificationController>().clearNotificationHistory();
                      },
                    ),

                    const Divider(),
                    SizedBox(height: Dimensions.height20),

                    AccountWidget(
                      icon: Icons.privacy_tip_outlined,
                      bigText: BigText(text: 'Privacy'),
                      onPressed: () {
                        print('Support');
                      },
                    ),
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
