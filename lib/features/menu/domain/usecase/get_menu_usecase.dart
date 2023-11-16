// import '../repositories/local_repository.dart';

import 'package:localeats/features/menu/domain/entities/entities.dart';

import '../repository/menu_repository.dart';

class GetMenuUsecase {
  final MenuRepository menuRepository;

  GetMenuUsecase(this.menuRepository);

  Future<List<Menu>> execute(Menu data) async {

  print("al menos bloc");
    
    try {
      // Llama al repositorio para obtener la lista de locales
      // final locales = await MenuRepository.getMenu(data);
      final locales = await menuRepository.getMenu(data);

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de la ubicacion está vacía');
      }
    } catch (e) {
      print('Error al obtener menu: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
