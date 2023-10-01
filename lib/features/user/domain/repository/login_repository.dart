import 'package:localeats/features/user/domain/entities/login.dart';

abstract class LoginUserRepository {
  Future<List<User>> login(User user);
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
}
