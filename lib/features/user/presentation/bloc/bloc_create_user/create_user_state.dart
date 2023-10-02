import 'package:localeats/features/user/domain/entities/login.dart';

import '../../../domain/entities/user.dart';

enum UserRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class CreateState {
  const CreateState({
    this.user = const [],
    this.userStatus = UserRequest.unknown,
    // this.token = const {},
  });

  final List<UserCreate> user;
  final UserRequest userStatus;
  // final Set<String> token;

  CreateState copyWith({
    List<UserCreate>? user,
    CreateState? userState,
    // Set<String>? token,
    required userStatus,
  }) =>
      CreateState(
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
        // token: token ?? this.token,
      );
}
