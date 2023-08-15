class AuthModel {
  final String? fullName;
  final String? phone;
  final String password;
  final String email;
  final String? city;
  final String? fcmToken;

  AuthModel({this.fullName, this.phone, required this.password, required this.email, this.city, this.fcmToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phone': phone,
      'password': password,
      'email': email,
      'city': city,
      'fcmToken': fcmToken
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
        fullName: map['fullName'] as String,
        phone: map['phone'] as String,
        password: map['password'] as String,
        email: map['email'] as String,
        city: map['city'] as String,
        fcmToken: map['fcmToken'] as String);
  }
}
