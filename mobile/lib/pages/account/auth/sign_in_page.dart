import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:get/get.dart';

import '../../../base/show_custom_snackbar.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../helper/firebase.dart';
import '../../../model/auth_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  void fetchUserInfo() {
    Get.find<UserController>().getUserInfo().then((response) {});
  }

  void fetchUserOrders() {
    Get.find<CartController>().getAllOrders();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<String> _getUserFcmToken() async {
    String fcmToken = await FirebaseHelper().requestFCMPermissionAndPrintToken();
    return fcmToken;
  }

  void login() async {
    var authController = Get.find<AuthController>();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      showCustomSnackbar("Please enter your name", title: "Name");
    } else if (password.isEmpty) {
      showCustomSnackbar("Please enter your phone number", title: "Phone Number");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackbar("Please enter a valid email address", title: "Email");
    } else if (password.isEmpty) {
      showCustomSnackbar("Please enter your password", title: "Password");
    } else {
      String fcmToken = await _getUserFcmToken();
      AuthModel user = AuthModel(
        email: email,
        password: password,
        fcmToken: fcmToken,
      );
      print('Login initiated');

      authController.loginUser(user).then((response) {
        if (response.isSuccess) {
          fetchUserInfo();
          fetchUserOrders();
          showCustomSnackbar("Login successful! ${response.message}", title: "Success", isError: false);
          Get.toNamed(RouteHelper.getInitial(0));
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
                height: Dimensions.height20 * 6,
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
                            Text("Hello.",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 1.5 + Dimensions.font20 / 2,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text("Welcome Back",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 1.3 + Dimensions.font20 / 2,
                                  fontWeight: FontWeight.w600,
                                )),
                            RichText(
                                text: TextSpan(
                                    recognizer: null,
                                    text: "Sign in to your account",
                                    style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16))),
                          ],
                        ),
                        const Icon(
                          Icons.food_bank_outlined,
                          color: AppColors.mainColor,
                          size: 100,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20 * 5),
              AppTextField(
                controller: emailController,
                hintText: 'Enter email',
                icon: Icons.email_outlined,
              ),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                controller: passwordController,
                hintText: 'Enter password',
                icon: Icons.lock_open_rounded,
                isObscure: true,
              ),
              SizedBox(height: Dimensions.height15 / 1.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          recognizer: null,
                          text: "Forgot Password?",
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16))),
                  SizedBox(
                    width: Dimensions.width20,
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20 * 3),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight / 14,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius15), color: AppColors.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Sign In",
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
                          recognizer: null,
                          text: "Don't have an account?",
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16))),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteHelper.getSignUpPage()),
                          text: " Create",
                          style: TextStyle(color: Colors.black, fontSize: Dimensions.font16, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
        ));
  }
}
