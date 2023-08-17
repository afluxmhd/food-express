import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_express/controller/notification_controller.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/utils/dimensions.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/modal_bottom_sheet_widget.dart';
import '../../widgets/small_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  Future<dynamic> openBottomSheet(BuildContext context) {
    return ModalBottomSheetWidget(
      options: const ['All', 'This Week', 'Today'],
      selectedValue: 'Today',
      onChanged: (value) {
        print(value);
      },
    ).openBottomSheet(context);
  }

  String formatTime(String timeStamp) {
    List<String> parts = timeStamp.split(' ');
    String time = parts[1].split('.')[0];
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: Column(
        children: [
          SizedBox(height: Dimensions.height10 * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: 'Notification',
                    size: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () => openBottomSheet(context),
                              text: "Today",
                              style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16))),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: AppColors.mainBlackColor,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius15), color: AppColors.mainColor),
                child: GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: Dimensions.iconsize24,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          //Notification
          GetBuilder<NotificationController>(builder: (notificationController) {
            var notificationList = notificationController.notificationList.reversed.toList();
            return Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: notificationList.length,
                separatorBuilder: (context, builder) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, bottom: Dimensions.height10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image section
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: AppColors.mainColor,
                            child: Icon(
                              Icons.food_bank_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width10 - 5),
                        //text section
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(text: notificationList[index].title),
                                  SmallText(text: notificationList[index].message),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SmallText(text: formatTime(notificationList[index].time), color: Colors.black45),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
