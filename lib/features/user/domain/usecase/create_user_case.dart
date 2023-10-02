import '../entities/user.dart';
import '../repository/login_repository.dart';

class USerCreateUseCase {
  final LoginUserRepository userRepository;

  USerCreateUseCase(this.userRepository);
  Future<List<UserCreate>> execute(UserCreate user)async {
    // print("caso get token");
    return await userRepository.userCreate(user);
  }
}
