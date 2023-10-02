
import '../../../domain/entities/user.dart';

abstract class CreateUserEvent {
  const CreateUserEvent();
}

class CreateUserRequest extends CreateUserEvent {
  const CreateUserRequest(this.user);
  final UserCreate user;
}

