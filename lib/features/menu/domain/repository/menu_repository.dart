import '../entities/entities.dart';

abstract class MenuRepository {
  Future<List<Menu>> getMenu(data);
  Future<Menu> menuCreate(data);
}
