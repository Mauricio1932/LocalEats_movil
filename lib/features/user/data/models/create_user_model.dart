
import '../../domain/entities/user.dart';

class CreateUserLoginModel extends UserCreate {
  CreateUserLoginModel({
    required String name,
    required String pass,
    required String email,
    required String telefono,
  }) : super(
          name: name,
          pass: pass,
          email: email,
          telefono: telefono,
        );

  factory CreateUserLoginModel.fromJson(Map<String, dynamic> json) {
    return CreateUserLoginModel(
      name: json['name'],
      pass: json['pass'],
      email: json['email'],
      telefono: json['telefono'],
    );
  }

  factory CreateUserLoginModel.fromEntity(UserCreate user) {
    return CreateUserLoginModel(
      name: user.name,
      pass: user.pass,
      email: user.email,
      telefono: user.telefono,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pass': pass,
      'email': email,
      'telefono': telefono,
    };
  }
}
