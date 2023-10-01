import 'package:localeats/features/user/domain/entities/login.dart';

abstract class UserEvent {
  const UserEvent();
}

class GetAuthToken extends UserEvent {}

class LoginUserRequest extends UserEvent {
  const LoginUserRequest(this.user);
  final User user;
}

class RemoveAuthToken extends UserEvent {
  // const DeleteUserToken(this.user);
  // final User user;
}

