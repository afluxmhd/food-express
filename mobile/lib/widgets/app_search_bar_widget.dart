import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppSearchBarWidget extends StatelessWidget {
  AppSearchBarWidget({super.key, required this.controller, required this.hintText, required this.icon, this.isObscure = false});

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(
            icon,
            color: AppColors.iconColor1,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                width: 1.5,
                color: Colors.grey,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.grey,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
