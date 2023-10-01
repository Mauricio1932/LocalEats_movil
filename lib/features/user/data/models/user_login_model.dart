import 'package:localeats/features/user/domain/entities/login.dart';

class UserLoginModel extends User {
  UserLoginModel({
    required String username,
    required String password,
    required String token,
  }) : super(
          username: username,
          password: password,
          token: token,
        );

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      username: json['username'],
      password: json['password'],
      token: json['token'],
    );
  }

  factory UserLoginModel.fromEntity(User user) {
    return UserLoginModel(
      username: user.username,
      password: user.password,
      token: user.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'token': token,
    };
  }
}
