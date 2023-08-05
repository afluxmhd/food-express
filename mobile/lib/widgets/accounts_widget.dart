import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget(
      {super.key, required this.icon, required this.bigText, this.onPressed, this.switchButton = false, this.switchValue});

  final IconData icon;
  final BigText bigText;
  final void Function()? onPressed;
  final bool switchButton;
  final bool? switchValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20 * 1.2),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: bigText.text == 'Logout' ? Colors.red : Colors.black54,
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                bigText,
              ],
            ),
            Row(
              children: [
                bigText.text == "Change Address"
                    ? const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                        size: 20,
                      )
                    : switchButton
                        ? Switch(
                            value: switchValue!,
                            onChanged: (value) {
                              print(value);
                            })
                        : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
