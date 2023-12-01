// import '../repositories/local_repository.dart';

import 'package:localeats/features/menu/domain/entities/entities.dart';

import '../repository/menu_repository.dart';

class PostMenuUsecase {
  final MenuRepository menuRepository;

  PostMenuUsecase(this.menuRepository);

  Future<Menu> execute(Menu data) async {
    print("al menos bloc");

    try {
      // Llama al repositorio para obtener la lista de locales
      // final locales = await MenuRepository.getMenu(data);
      final locales = await menuRepository.menuCreate(data);

      if (locales.pdf != "") {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La del pdf esta vacia');
      }
    } catch (e) {
      print('Error al subir menu: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
