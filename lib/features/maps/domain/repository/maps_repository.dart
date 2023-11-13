import '../entities/entities.dart';

abstract class MapsRepository {
  Future<List<Maps>> getUbicacion();
}
