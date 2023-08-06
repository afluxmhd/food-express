import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_express/data/repo/popular_product_repo.dart';
import 'package:food_express/model/product_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  PopularProductController({required this.popularProductRepo});
  final PopularProductRepo popularProductRepo;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isloaded = false;
  bool get isloaded => _isloaded;

  int get quantity => _quantity;
  int _quantity = 0;

  int get inCartItems => _inCartItems + _quantity;
  int _inCartItems = 0;

  List<CartModel> get getItems {
    return _cart.getItems;
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductlist();
    if (response.statusCode == 200) {
      _popularProductList = [];

      for (dynamic json in response.body) {
        _popularProductList.add(ProductModel.fromMap(json));
      }
      _isloaded = true;
      print("Got popular products: Length is ${_popularProductList.length}");
      update();
    } else {
      print("Could not get popular products");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more!", backgroundColor: AppColors.mainColor, colorText: Colors.white);

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You can't add more!", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(product);
    print("Exist :" + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The ID is ${value.id} | The quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }
}
