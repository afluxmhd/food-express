class PromoCodeModel {
  String mongoId;
  String title;
  String description;
  String code;
  int discountPercentage;
  bool? isApplied;

  PromoCodeModel({
    required this.mongoId,
    required this.title,
    required this.description,
    required this.code,
    required this.discountPercentage,
    this.isApplied = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': mongoId,
      'title': title,
      'description': description,
      'code': code,
      'discountPercentage': discountPercentage,
    };
  }

  factory PromoCodeModel.fromMap(Map<String, dynamic> map) {
    return PromoCodeModel(
      mongoId: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      code: map['code'] as String,
      discountPercentage: map['discountPercentage'] as int,
    );
  }
}
