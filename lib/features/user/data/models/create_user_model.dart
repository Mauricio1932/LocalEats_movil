
import '../../domain/entities/user.dart';

class CreateUserLoginModel extends UserCreate {
  CreateUserLoginModel({
    required String username,
    required String password,
    required String email,
  }) : super(
          username: username,
          password: password,
          email: email,
        );

  factory CreateUserLoginModel.fromJson(Map<String, dynamic> json) {
    return CreateUserLoginModel(
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }

  factory CreateUserLoginModel.fromEntity(UserCreate user) {
    return CreateUserLoginModel(
      username: user.username,
      password: user.password,
      email: user.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
