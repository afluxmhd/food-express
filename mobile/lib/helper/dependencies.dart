import 'package:food_express/controller/cart_controller.dart';
import 'package:food_express/data/repo/cart_repo.dart';
import 'package:get/get.dart';

import '../controller/popular_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repo/popular_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
