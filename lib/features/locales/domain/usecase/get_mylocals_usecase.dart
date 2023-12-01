import '../entities/local.dart';
import '../repository/locales_repository.dart';
// import '../repositories/local_repository.dart';

class GetMyLocalUsecase {
  final LocalRepository localRepository;

  GetMyLocalUsecase(this.localRepository);

  Future<List<Local>> execute() async {
    print("se ejecuto el usecase getMylocals");
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await localRepository.getMyLocals();

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de locales está vacía');
      }
    } catch (e) {
      print('Error al obtener locales: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
