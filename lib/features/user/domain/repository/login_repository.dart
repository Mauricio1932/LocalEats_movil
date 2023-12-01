import 'package:localeats/features/user/domain/entities/login.dart';
import 'package:localeats/features/user/domain/entities/user.dart';

import '../../data/models/create_user_model.dart';

abstract class LoginUserRepository {
  Future<List<User>> login(User user);
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
  Future<CreateUserLoginModel> userCreate(UserCreate user);
}
