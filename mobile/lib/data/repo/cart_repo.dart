import 'dart:convert';

import 'package:food_express/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  CartRepo({required this.sharedPreferences, required this.apiClient});

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    //Converting objects to string coz sharedpreference only accepts String
    cart = cartList.map((cart) {
      cart.time = time;
      return json.encode(cart.toMap());
    }).toList();
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print('ADDED DATA To SharedPref\n ${sharedPreferences.getStringList(AppConstants.CART_LIST)}');
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("FETCHED DATA FROM SharedPref\n  :${carts}");
    }
    List<CartModel> cartList = [];

    cartList = carts.map((cart) {
      Map<String, dynamic> map = json.decode(cart);
      return CartModel.fromMap(map);
    }).toList();

    print('Length of CartList from Shared prefs: ' + cartList.length.toString());

    return cartList;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  Future<Response> addToOrderList(dynamic body) async {
    return await apiClient.postData(AppConstants.ORDERS_URI, body);
  }

  Future<Response> getAllOrderList(String userId) async {
    return await apiClient.getData('${AppConstants.ORDERS_URI}/$userId');
  }
}
