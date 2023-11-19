import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';

import '../entities/local.dart';
import '../repository/locales_repository.dart';

class PostNewLocalUsecase {
  final LocalRepository localRepository;

  PostNewLocalUsecase(this.localRepository);

  Future<Local> execute(local) async {
    print("object usecase");
    try {
      // Llama al repositorio para crear el nuevo local
      final newlocal = await localRepository.createLocal(local);

      // ignore: unnecessary_null_comparison
      if (newlocal != null) {
        return newlocal; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de locales está vacía');
      }
    } catch (e) {
      print('Error al crear el nuevo local: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
