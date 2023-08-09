// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.quantity,
    required this.isExist,
    required this.time,
    required this.product,
  });
  int id;
  String name;
  double price;
  String img;
  int quantity;
  bool isExist;
  String time;
  ProductModel product;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'product': product.toMap(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      img: map['img'] as String,
      quantity: map['quantity'] as int,
      isExist: map['isExist'] as bool,
      time: map['time'] as String,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }
}
