import 'package:food_express/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class PopularProductRepo {
  PopularProductRepo({required this.apiClient});

  final ApiClient apiClient;

  Future<Response> getPopularProductlist() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
