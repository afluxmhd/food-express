import 'package:food_express/controller/auth_controller.dart';
import 'package:food_express/controller/cart_controller.dart';
import 'package:food_express/controller/notification_controller.dart';
import 'package:food_express/controller/user_controller.dart';
import 'package:food_express/data/repo/auth_repo.dart';
import 'package:food_express/data/repo/cart_repo.dart';
import 'package:food_express/data/repo/notification_repo.dart';
import 'package:food_express/data/repo/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/popular_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repo/popular_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => NotificationRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
}
