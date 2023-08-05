// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.city,
  });
  int id;
  String fullName;
  String email;
  String phone;
  String city;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], fullName: json['full_name'], email: json['email'], phone: json['phone'], city: json['city']);
  }
}
