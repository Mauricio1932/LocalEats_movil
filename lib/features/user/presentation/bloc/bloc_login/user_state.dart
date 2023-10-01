import 'package:localeats/features/user/domain/entities/login.dart';

enum UserRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class UserState {
  const UserState({
    this.user = const [],
    this.userStatus = UserRequest.unknown,
    this.token = const {},
  });

  final List<User> user;
  final UserRequest userStatus;
  final Set<String> token;

  UserState copyWith({
    List<User>? user,
    UserState? userState,
    Set<String>? token,
    required userStatus,
  }) =>
      UserState(
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
        token: token ?? this.token,
      );
}
