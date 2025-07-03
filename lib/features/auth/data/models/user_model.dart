import 'package:youapp/features/auth/domain/entity/user.dart';

class UserModel extends User {
  final String? token;

  const UserModel({
    required String username,
    required String email,
    required String password,
    this.token,
  }) : super(username: username, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
