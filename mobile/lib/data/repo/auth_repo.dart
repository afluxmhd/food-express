// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_express/data/api/api_client.dart';
import 'package:food_express/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  AuthRepo({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> registerUser(dynamic body) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, body);
  }

  Future<Response> loginUser(dynamic body) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, body);
  }

  bool isUserLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> saveId(String id) async {
    return await sharedPreferences.setString(AppConstants.USER_ID, id);
  }

  void logoutUser() async {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER_ID);
  }
}
