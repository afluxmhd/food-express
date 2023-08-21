import 'package:food_express/data/api/api_client.dart';
import 'package:food_express/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getUserInfo(String id) {
    return apiClient.getData('${AppConstants.USER_INFO_URI}?&userId=$id');
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.USER_ID) ?? "";
  }

  String getUserFcmToken() {
    return sharedPreferences.getString(AppConstants.FCM_TOKEN) ?? "";
  }

  Future<Response> updateUserInfo(String id, dynamic body) {
    return apiClient.patchData('${AppConstants.USER_UPDATE_URI}/$id', body);
  }
}
