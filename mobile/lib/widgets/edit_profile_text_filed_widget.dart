import 'package:flutter/material.dart';
import 'package:food_express/widgets/big_text.dart';

import '../utils/dimensions.dart';

class EditProfileTextFieldWidget extends StatelessWidget {
  const EditProfileTextFieldWidget({super.key, required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.height20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText == 'Phone' ? null : hintText,
          hintText: hintText == 'Phone' ? hintText : null,
          prefixIcon: hintText == 'Phone'
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: Dimensions.width10),
                    BigText(text: '+91'),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 10, minHeight: 0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1.5,
                color: Colors.grey,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
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
