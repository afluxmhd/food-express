// ignore_for_file:  sort_constructors_first
import 'dart:convert';

import 'package:food_express/model/product_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_firs

class OrderModel {
  OrderModel({
    this.mongoId,
    required this.orderId,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.totalQuantity,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? mongoId;
  String orderId;
  String userId;
  List<OrderProduct> products;
  double totalAmount;
  int totalQuantity;
  String status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'orderId': orderId,
      'products': products.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'totalQuantity': totalQuantity,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      mongoId: map['_id'] != null ? map['_id'] as String : null,
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      products: List<OrderProduct>.from(
        (map['products'] as List<dynamic>).map<OrderProduct>(
          (x) => OrderProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalAmount: map['totalAmount'] as double,
      totalQuantity: map['totalQuantity'] as int,
      status: map['status'] as String,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }
}

class OrderProduct {
  OrderProduct({
    required this.productId,
    required this.quantity,
  });
  ProductModel productId;
  int quantity;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productId: ProductModel.fromMap(map['productId'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }
}
