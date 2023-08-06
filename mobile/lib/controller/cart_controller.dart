// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:food_express/data/repo/cart_repo.dart';

import '../model/cart_model.dart';
import '../model/product_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  CartController({required this.cartRepo});
  final CartRepo cartRepo;

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.update(product.productId, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: product.productId,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.productId);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.productId, () {
          return CartModel(
            id: product.productId,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("Item count", "You should atleast add 1 item in the cart",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    //To Repo Storaage addItems()
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.productId)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.forEach((key, value) {
        if (key == product.productId) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  //setter for _setCart
  set _setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.productId, () => storageItems[i]);
    }
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  List<CartModel> getCartdata() {
    //_setCart = cartRepo.getCartList();
    return storageItems;
  }

  void addToHistory() {
    //cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }
//  List<CartModel> getCartHistoryList() {
//     return cartRepo.getCartHistoryList();
//   }

  void clearCartHistory() {
    //cartRepo.clearCartHistory();
    update();
  }

  void addToCartList() {
    //cartRepo.addToCartList(getItems);
    update();
  }
}
