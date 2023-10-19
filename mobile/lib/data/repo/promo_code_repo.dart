// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_express/data/api/api_client.dart';
import 'package:food_express/utils/app_constants.dart';
import 'package:get/get.dart';

class PromoCodeRepo {
  final ApiClient apiClient;
  PromoCodeRepo({required this.apiClient});

  Future<Response> getPromocodesList() async {
    return await apiClient.getData(AppConstants.PROMO_URI);
  }
}
