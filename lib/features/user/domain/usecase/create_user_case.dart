import '../../data/models/create_user_model.dart';
import '../entities/user.dart';
import '../repository/login_repository.dart';

class USerCreateUseCase {
  final LoginUserRepository userRepository;

  USerCreateUseCase(this.userRepository);
  Future<CreateUserLoginModel> execute(UserCreate user) async {
    try {
      // Llama al repositorio para crear el nuevo local
      // final user = await userRepository.userCreate(user);
      final newUser = await userRepository.userCreate(user);
      // ignore: unnecessary_null_comparison
      if (newUser != null) {
        return newUser; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de locales está vacía');
      }
    } catch (e) {
      print('Error al crear el usuario: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
