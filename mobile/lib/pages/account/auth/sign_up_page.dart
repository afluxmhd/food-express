import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_express/helper/firebase.dart';
import 'package:food_express/model/auth_model.dart';
import 'package:food_express/pages/account/auth/sign_in_page.dart';
import 'package:get/get.dart';

import '../../../base/show_custom_snackbar.dart';
import '../../../controller/auth_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var confirmPassowordController = TextEditingController();

  Future<String> _getUserFcmToken() async {
    String fcmToken = await FirebaseHelper().requestFCMPermissionAndPrintToken();
    return fcmToken;
  }

  void registration() async {
    var authController = Get.find<AuthController>();

    // print(authController.isloading);

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassowordController.text.trim();

    if (name.isEmpty) {
      showCustomSnackbar("Please enter your name", title: "Name");
    } else if (phone.isEmpty) {
      showCustomSnackbar("Please enter your phone number", title: "Phone Number");
    } else if (email.isEmpty) {
      showCustomSnackbar("Please enter your email address", title: "Email");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackbar("Please enter a valid email address", title: "Email");
    } else if (password.isEmpty) {
      showCustomSnackbar("Please enter your password", title: "Password");
    } else if (password.length < 6) {
      showCustomSnackbar("Password must be at least 6 characters long", title: "Password");
    } else if (password != confirmPassword) {
      showCustomSnackbar("Confirmed password does not match", title: "Password");
    } else {
      String fcmToken = await _getUserFcmToken();
      AuthModel user = AuthModel(
        fullName: name,
        phone: phone,
        email: email,
        password: password,
        city: 'Bangalore',
        fcmToken: fcmToken,
      );

      print(user.toMap());

      authController.registerUser(user).then((response) {
        if (response.isSuccess) {
          showCustomSnackbar("Sign-up successful! ${response.message}", title: "Success", isError: false);
          Get.toNamed(RouteHelper.getSignInPage());
        } else {
          showCustomSnackbar(response.message, title: "Error");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height20 * 4,
              ),
              //Welcome Section
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Getting Started",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 1.5 + Dimensions.font20 / 2,
                                  fontWeight: FontWeight.w600,
                                )),
                            RichText(
                                text: TextSpan(
                                    recognizer: null,
                                    text: " Create an account to continue!",
                                    style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16))),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height15),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Wrap(
                  children: List.generate(
                    3,
                    (index) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.facebook,
                        color: Colors.blueAccent,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20 * 2),
              AppTextField(controller: nameController, hintText: 'Enter Name', icon: Icons.person_outline),
              SizedBox(height: Dimensions.height20),
              AppTextField(controller: emailController, hintText: 'Enter email', icon: Icons.email_outlined),
              SizedBox(height: Dimensions.height20),
              AppTextField(controller: phoneController, hintText: 'Enter Phone', icon: Icons.phone_outlined),
              SizedBox(height: Dimensions.height20),
              AppTextField(controller: passwordController, hintText: 'Enter password', icon: Icons.lock_outline, isObscure: true),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                  controller: confirmPassowordController,
                  hintText: 'Confirm password',
                  icon: Icons.lock_outline,
                  isObscure: true),
              SizedBox(height: Dimensions.height20 * 2),
              GestureDetector(
                onTap: () {
                  registration();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight / 14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      size: Dimensions.font20 + Dimensions.font20 / 2.3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Have an account already?',
                          style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16))),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteHelper.getSignInPage()),
                          text: " Sign in",
                          style: TextStyle(color: Colors.black, fontSize: Dimensions.font16, fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(height: Dimensions.height20 * 2),
            ],
          ),
        ));
  }
}
