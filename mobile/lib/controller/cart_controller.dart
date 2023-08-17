// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_express/base/show_custom_snackbar.dart';
import 'package:food_express/controller/user_controller.dart';
import 'package:food_express/helper/generate_id.dart';
import 'package:food_express/model/order_model.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<OrderModel> _allOrders = [];
  List<OrderModel> get allOrders => _allOrders;

  List<String> filterOptions = ['Current', 'Completed', 'Cancelled'];
  String _selectedFilterOption = 'Current';
  String get selectedFilterOption => _selectedFilterOption;

  bool _isloading = false;
  bool get isloading => _isloading;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.update(product.productId, (value) {
        totalQuantity = value.quantity + quantity;
        return CartModel(
          id: product.productId,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: value.quantity + quantity,
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
    addToCartList(); //Adding to CartRepo Storage
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
          quantity = value.quantity;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  //setter for _setCart
  set _setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product.productId, () => storageItems[i]);
    }
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModel> getCartdata() {
    _setCart = cartRepo.getCartList();
    return storageItems;
  }

  Future<String> addToOrderList() async {
    _isLoading = true;
    update();
    List<OrderProduct> products = [];
    int totalQuantity = 0;

    for (var cart in getItems) {
      products.add(OrderProduct(productId: cart.product, quantity: cart.quantity));
      totalQuantity += cart.quantity;
    }
    String userId = Get.find<UserController>().userModel.id;

    String newOrderId = GenerateId().generateOrderId(userId);

    OrderModel order = OrderModel(
      orderId: newOrderId,
      userId: userId,
      status: "Pending",
      totalAmount: totalAmount,
      totalQuantity: totalQuantity,
      products: products,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );
    dynamic orderBody = order.toMap();
    String orderId = " ";

    try {
      var response = await cartRepo.addToOrderList(orderBody);
      if (response.statusCode == 200) {
        clearCart();
        orderId = response.body['orderId'];
        print(orderId);
        print('Success order');
      } else {
        showCustomSnackbar('Something Went Wrong.', title: 'Order Failed');
        orderId = 'Order Failed';
      }
    } catch (error) {
      showCustomSnackbar('An error occurred.', title: 'Order Failed');
      orderId = 'Order Failed';
    }
    return orderId;
  }

  void printOrderDetails(OrderModel order) {
    print('Order ID: ${order.mongoId}');
    print('User ID: ${order.userId}');
    print('Total Amount: ${order.totalAmount}');
    print('Total Quantity: ${order.totalQuantity}');
    print('Status: ${order.status}');
    print('Created At: ${order.createdAt}');

    print('Products:');
    for (var product in order.products) {
      print('  Product ID: ${product.productId.name}');
      print('  Quantity: ${product.quantity}');
    }
  }

  void getAllOrders() async {
    _isloading = true;
    update();
    String userId = Get.find<UserController>().getUserId();
    Response response = await cartRepo.getAllOrderList(userId);

    _allOrders = [];

    for (dynamic json in response.body) {
      _allOrders.add(OrderModel.fromMap(json));
    }
    print('All orders fetched ${_allOrders.length}');

    _isloading = false;
    update();
  }

  void changeFilterOption(String option) {
    _isloading = true;
    update();
    _selectedFilterOption = option;
    print('Selected filter opt:' + _selectedFilterOption);
    _isloading = false;
    update();
  }

  void clearCart() {
    _items = {};
    cartRepo.removeCart();
    print('Shared Preferences and ram cart removed');
    update();
  }
}
