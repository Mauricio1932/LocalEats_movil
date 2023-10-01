// En el archivo use_case/login_user_usecase.dart

// import 'package:localeats/features/user/domain/repositories/login_repository.dart';

import '../repository/login_repository.dart';

class GetAuthTokenUseCase {
  final LoginUserRepository userRepository;

  GetAuthTokenUseCase(this.userRepository);
  Future<String> execute() async {
    // print("caso get token");
    return await userRepository.getAuthToken();
  }
}
