import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.city,
  });

  String id;
  String fullName;
  String email;
  String phone;
  String city;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'city': city,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
    );
  }
}
