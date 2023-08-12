import 'package:flutter/material.dart';
import 'package:food_express/widgets/app_icon.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:food_express/widgets/big_text_with_radio.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  const ModalBottomSheetWidget({super.key, required this.options, required this.selectedValue, required this.onChanged});

  final List<String> options;
  final String selectedValue;
  final void Function(String?) onChanged;

  Future<dynamic> openBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: 185,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: AppIcon(icon: Icons.remove_outlined, iconSize: 32),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      BigText(text: 'Sort by', fontWeight: FontWeight.bold, size: 20),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                      child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return BigTextWithCheckWidget(
                              bigText: BigText(text: options[index]),
                              groupValue: selectedValue,
                              onChanged: onChanged,
                            );
                          }))
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
