class ProductModel {
  int productId;
  String name;
  String description;
  int price;
  String img;
  double rating;
  int stars;
  String createdAt;
  String updatedAt;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.img,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'img': img,
      'rating': rating,
      'stars': stars,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      img: map['img'] as String,
      rating: map['rating'] as double,
      stars: map['stars'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}
