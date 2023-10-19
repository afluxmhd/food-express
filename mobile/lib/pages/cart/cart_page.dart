import 'package:flutter/material.dart';
import 'package:food_express/base/custom_info_page.dart';
import 'package:food_express/base/item_empty_page.dart';
import 'package:food_express/base/show_custom_snackbar.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:food_express/controller/promo_code_controller.dart';
import 'package:food_express/routes/route_helper.dart';
import 'package:food_express/widgets/order_summary_widget.dart';
import 'package:food_express/widgets/promo_card_widget.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void fetchOrders() {
    Get.find<CartController>().getAllOrders();
  }

  void updatePromoCodeDiscountAndTotalAmount(double subTotal) {
    Get.find<PromoCodeController>().getSelectedPromoDiscount(subTotal);
    double discountValue = Get.find<PromoCodeController>().discountValue;
    Get.find<CartController>().calculateTotalAmount(discountValue);
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().calculateTotalAmount(0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height20 * 2),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: BigText(
                      text: 'My Cart',
                      size: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: GetBuilder<CartController>(builder: (cartController) {
              var _cartList = cartController.getItems;
              return ListView(
                children: [
                  _cartList.isEmpty
                      ? ItemEmptyPage(
                          imagePath: 'asset/empty_cart.png',
                          title: 'Your Cart is Empty',
                          descriptionOne: 'Explore our menu and add delicious dishes to your cart.')
                      : Column(
                          children: _cartList.map(
                            (item) {
                              return SizedBox(
                                height: Dimensions.height20 * 5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print('cart product tapped!');
                                      },
                                      child: Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage("asset/shawarma.png"),
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text: item.name, color: Colors.black54),
                                            const SmallText(text: "Cart Product"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: '\$${item.price}', color: Colors.black54),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(item.product, -1);
                                                          updatePromoCodeDiscountAndTotalAmount(cartController.subTotalAmount);
                                                        },
                                                        child: const Icon(Icons.remove, color: AppColors.signColor),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions.width10 / 2,
                                                      ),
                                                      BigText(text: item.quantity.toString()),
                                                      SizedBox(
                                                        width: Dimensions.width10 / 2,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(item.product, 1);
                                                          updatePromoCodeDiscountAndTotalAmount(cartController.subTotalAmount);
                                                        },
                                                        child: const Icon(Icons.add, color: AppColors.signColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                  const SizedBox(height: 16),
                  _cartList.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: 'Promo Code'),
                            const SizedBox(height: 10),
                            GetBuilder<PromoCodeController>(
                              builder: (promoCodeController) {
                                var _promoCodelist = promoCodeController.promocodeList;
                                return Column(
                                  children: _promoCodelist.map(
                                    (promoCode) {
                                      return PromoCardWidget(
                                        code: promoCode.code,
                                        description: promoCode.description,
                                        onTap: () {
                                          promoCodeController.applyPromoCode(promoCode.code);
                                          promoCodeController.getSelectedPromoDiscount(cartController.subTotalAmount);
                                          cartController.calculateTotalAmount(promoCodeController.discountValue);
                                        },
                                        isApplied: promoCode.isApplied!,
                                      );
                                    },
                                  ).toList(),
                                );
                              },
                            )
                          ],
                        )
                ],
              );
            }))
          ],
        ),
      ),
      //bottom nav bar contains total price and checkout
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: cartController.getItems.isNotEmpty ? Dimensions.bottomheightBar * 2.1 : Dimensions.bottomheightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height20, bottom: Dimensions.width20, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2), topRight: Radius.circular(Dimensions.radius20 * 2))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cartController.getItems.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height20,
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Order Summary', fontWeight: FontWeight.w500),
                          const SizedBox(height: 10),
                          OrderSummaryWidget(title: 'Sub Total', value: cartController.subTotalAmount.toStringAsFixed(2)),
                          GetBuilder<PromoCodeController>(builder: (promoCodeController) {
                            double discountValue = promoCodeController.discountValue;
                            return OrderSummaryWidget(title: 'Promo Code Applied', value: discountValue.toStringAsFixed(2));
                          }),
                          const OrderSummaryWidget(title: 'Delivery fee', value: '4'),
                        ],
                      ),
                    )
                  : const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20), color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(text: '\$${cartController.totalAmount.toStringAsFixed(2)}'),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (cartController.getItems.isNotEmpty) {
                        String orderId = await cartController.addToOrderList();
                        fetchOrders();
                        Get.to(
                            () => CustomInfoPage(
                                  appBarTitle: 'Order',
                                  imagePath: 'asset/order_success.png',
                                  title: 'Your Order Successful!',
                                  descriptionOne: 'Your Order is on the way!',
                                  descriptionTwo: 'Order ID: $orderId',
                                  onPressedMain: () {
                                    Get.toNamed(RouteHelper.getInitial(1));
                                  },
                                ),
                            transition: Transition.rightToLeft);
                      } else {
                        showCustomSnackbar('Add Item to your cart', title: 'Cart is Empty');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: BigText(
                        text: "Check Out",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
