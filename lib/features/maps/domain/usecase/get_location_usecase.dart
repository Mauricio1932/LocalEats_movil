// import '../repositories/local_repository.dart';

import 'package:localeats/features/maps/domain/entities/entities.dart';
import 'package:localeats/features/maps/domain/repository/maps_repository.dart';

class GetLocationUsecase {
  final MapsRepository mapsRepository;

  GetLocationUsecase(this.mapsRepository);

  Future<List<Maps>> execute(data) async {

  print("al menos bloc");
    
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await mapsRepository.getUbicacion(data);

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de la ubicacion está vacía');
      }
    } catch (e) {
      print('Error al obtener Ubicacion: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
