import 'package:flutter/material.dart';
import 'package:food_express/controller/user_controller.dart';
import 'package:food_express/model/user_model.dart';
import 'package:food_express/widgets/edit_profile_text_filed_widget.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  void editUserInfo() {
    //64dba34510c47f07d151b0c1
    var user = Get.find<UserController>().userModel;

    String fullName = '${firstNameController.text}${lastNameController.text}';
    if (user.fullName == fullName &&
        user.phone == phoneController.text &&
        user.email == emailController.text &&
        user.city == cityController.text) {
      print('No changes has been made');
    } else {
      UserModel updateUser = UserModel(
          id: user.id, fullName: fullName, email: emailController.text, phone: phoneController.text, city: cityController.text);
      Get.find<UserController>().updateUserInfo(updateUser);

      Get.snackbar("Profile", "Your profile has been updated successfully!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }

  void initializeUserValue() {
    var user = Get.find<UserController>().userModel;
    var fullName = user.fullName.split(' ');

    firstNameController.text = fullName[0];

    //last name joining
    for (int i = 1; i < fullName.length; i++) {
      lastNameController.text = '${lastNameController.text} ${fullName[i]}';
    }

    phoneController.text = user.phone;
    emailController.text = user.email;
    cityController.text = user.city;
  }

  @override
  Widget build(BuildContext context) {
    initializeUserValue();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height20 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    iconSize: Dimensions.iconsize24,
                  ),
                ),
                BigText(
                  text: 'Edit Profile',
                  size: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainBlackColor,
                ),
                GestureDetector(
                  onTap: () {
                    editUserInfo();
                    Get.offNamed(RouteHelper.getInitial(3));
                  },
                  child: const AppIcon(
                    icon: Icons.check_outlined,
                    iconColor: AppColors.mainColor,
                    backgroundColor: Colors.transparent,
                    iconSize: 26,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height20),
            Center(
              child: Stack(
                children: [
                  AppIcon(
                      icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height20 * 4,
                      size: Dimensions.height20 * 7),
                  Positioned(
                    top: 90,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54, width: 1.0),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            BigText(text: 'Your Information', fontWeight: FontWeight.w500),
            SizedBox(height: Dimensions.height20),
            EditProfileTextFieldWidget(
              hintText: 'First Name',
              controller: firstNameController,
            ),
            EditProfileTextFieldWidget(
              hintText: 'Last Name',
              controller: lastNameController,
            ),
            EditProfileTextFieldWidget(
              hintText: 'Phone',
              controller: phoneController,
            ),
            EditProfileTextFieldWidget(
              hintText: 'Email id',
              controller: emailController,
            ),
            EditProfileTextFieldWidget(
              hintText: 'City',
              controller: cityController,
            ),
          ],
        ),
      ),
    );
  }
}
