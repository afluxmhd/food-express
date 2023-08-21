import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_express/base/item_empty_page.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:food_express/model/order_model.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/utils/dimensions.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:food_express/widgets/modal_bottom_sheet_widget.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/small_text.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  String formatDate(String timeStamp) {
    List<String> parts = timeStamp.split(' ');

    String date = parts[0];
    String time = parts[1].split('.')[0];

    return '$date $time';
  }

  Future<dynamic> openBottomSheet(BuildContext context, CartController cartController) {
    return ModalBottomSheetWidget(
      options: const ['Current', 'Completed', 'Cancelled'],
      selectedValue: cartController.selectedFilterOption,
      onChanged: (value) {
        cartController.changeFilterOption(value!);
        Navigator.pop(context);
      },
    ).openBottomSheet(context);
  }

  int _getItemCount(String selectedFilter, List<OrderModel> allCurrentOrders, List<OrderModel> allCompletedOrders,
      List<OrderModel> allCanceledOrders) {
    if (selectedFilter == 'Current') {
      return allCurrentOrders.length;
    } else if (selectedFilter == 'Completed') {
      return allCompletedOrders.length;
    } else if (selectedFilter == 'Cancelled') {
      return allCanceledOrders.length;
    }
    return 0; // Default case
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: 'My Orders',
                    size: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      GetBuilder<CartController>(builder: (cartController) {
                        return RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    openBottomSheet(context, cartController);
                                  },
                                text: cartController.selectedFilterOption,
                                style: TextStyle(color: Colors.grey[600], fontSize: Dimensions.font16)));
                      }),
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
            ],
          ),
          //History Section
          SizedBox(height: Dimensions.height20),
          Expanded(child: GetBuilder<CartController>(builder: (cartController) {
            String selectedFilter = cartController.selectedFilterOption;

            var allOrders = cartController.allOrders.reversed.toList();
            var allCurrentOrders = allOrders.where((order) => order.status == 'Pending').toList();
            var allCompletedOrders = allOrders.where((order) => order.status == 'Completed').toList();
            var allCanceledOrders = allOrders.where((order) => order.status == 'Cancelled').toList();
            return cartController.isloading
                ? const Center(child: CircularProgressIndicator())
                : allOrders.isEmpty
                    ? ItemEmptyPage(
                        imagePath: 'asset/order_history.png',
                        title: 'No Orders Yet!',
                        descriptionOne: "Looks like you haven't made your menu yet.")
                    : ListView.builder(
                        itemCount: _getItemCount(selectedFilter, allCurrentOrders, allCompletedOrders, allCanceledOrders),
                        itemBuilder: (context, index) {
                          OrderModel? order;
                          if (selectedFilter == 'Current') {
                            order = allCurrentOrders[index];
                          } else if (selectedFilter == 'Completed') {
                            order = allCompletedOrders[index];
                          } else if (selectedFilter == 'Cancelled') {
                            order = allCanceledOrders[index];
                          } else {
                            order = null;
                          }

                          return Container(
                            height: 130,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatDate(order!.createdAt!),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                                SizedBox(height: Dimensions.height10 - 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(order.products.length, (index) {
                                        return Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                            color: AppColors.mainColor,
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "Total",
                                            style: TextStyle(fontSize: 16, color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10 / 2,
                                          ),
                                          BigText(text: order.totalQuantity.toString()),
                                          GestureDetector(
                                            onTap: () {
                                              print("Add to Cart");
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                                                decoration: BoxDecoration(
                                                  color: order.status == 'Pending' ? AppColors.mainColor : Colors.green,
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                                  border: Border.all(width: 1, color: AppColors.mainColor),
                                                ),
                                                child: SmallText(
                                                  text: order.status == 'Pending' ? "On the way" : "Completed",
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        });
          }))
        ],
      ),
    );
  }
}
