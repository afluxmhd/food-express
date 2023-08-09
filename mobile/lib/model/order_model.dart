// ignore_for_file: public_member_api_docs, sort_constructors_firs

class OrderModel {
  OrderModel({
    this.mongoId,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.totalQuantity,
    required this.products,
    this.createdAt,
    this.updatedAt,
  });

  String? mongoId;
  String userId;
  String status;
  double totalAmount;
  int totalQuantity;
  List<OrderProduct> products;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'status': status,
      'totalAmount': totalAmount,
      'totalQuantity': totalQuantity,
      'products': products.map((product) => product.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      mongoId: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] as String,
      status: map['status'] as String,
      totalAmount: map['totalAmount'] as double,
      totalQuantity: map['totalQuantity'] as int,
      products: (map['products'] as List<dynamic>).map((productMap) => OrderProduct.fromMap(productMap)).toList(),
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

  String productId;
  int quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
