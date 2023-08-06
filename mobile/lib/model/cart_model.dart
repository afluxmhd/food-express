import 'product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel({this.id, this.name, this.price, this.img, this.quantity, this.isExist, this.time, this.product});
}
