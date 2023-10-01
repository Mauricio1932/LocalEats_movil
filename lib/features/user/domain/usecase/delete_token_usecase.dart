

import '../repository/login_repository.dart';

class RemoveTokenUseCase {
  final LoginUserRepository userRepository;

  RemoveTokenUseCase(this.userRepository);
  Future<void> execute() async {
    // print("caso get token");
    return await userRepository.removeAuthToken();
  }
}
