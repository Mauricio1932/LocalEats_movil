import 'package:localeats/features/locales/domain/entities/local.dart';

import '../repository/locales_repository.dart';

class GetSingleLocalUsecase {
  final LocalRepository localRepository;

  GetSingleLocalUsecase(this.localRepository);

  Future<List<Local>> execute(localId) async {
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await localRepository.getSingleLocals(localId);

      // ignore: unnecessary_null_comparison
      if (locales != null) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de locales está vacía');
      }
    } catch (e) {
      print('Error al obtener locales simple: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
