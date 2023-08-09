import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:get/get.dart';
import '../../controller/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
  }

  void _loadCart() {
    Get.find<CartController>().getCartdata();
  }

  @override
  void initState() {
    _loadResources();
    _loadCart();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInToLinear);
    Timer(
      const Duration(seconds: 3),
      () => Get.toNamed(RouteHelper.getInitial(0)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Icon(
                Icons.food_bank,
                size: Dimensions.iconsize72,
                color: AppColors.mainColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ScaleTransition(
              scale: animation,
              child: BigText(
                text: "Food Express",
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
