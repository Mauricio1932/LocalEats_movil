import 'package:localeats/features/user/domain/entities/login.dart';
import 'package:localeats/features/user/domain/entities/user.dart';


abstract class LoginUserRepository {
  Future<List<User>> login(User user);
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
  Future<List<UserCreate>> userCreate(UserCreate user);
}
