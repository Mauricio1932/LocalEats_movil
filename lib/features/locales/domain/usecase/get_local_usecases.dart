import '../entities/local.dart';
import '../repository/locales_repository.dart';
// import '../repositories/local_repository.dart';

class GetLocalUsecase {
  final LocalRepository localRepository;

  GetLocalUsecase(this.localRepository);

  Future<List<Local>> execute() async {
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await localRepository.getLocals();

      print("estoy en caso de uso ${locales}");

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
