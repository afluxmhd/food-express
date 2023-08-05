import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
                  Get.toNamed(RouteHelper.getInitial(0));
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
