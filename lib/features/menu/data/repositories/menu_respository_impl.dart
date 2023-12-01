// import '../../domain/entities/local.dart';
// import '../../domain/repository/locales_repository.dart';
// import '../datasourses/locales_data_sourse.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repository/menu_repository.dart';
import '../datasource/menu_data_source.dart';

class MenuRepositoryImpl implements MenuRepository {
  final ApiMenuDatasourceImpl apiMenuDatasourceImpl;

  MenuRepositoryImpl({required this.apiMenuDatasourceImpl});

  @override
  Future<List<Menu>> getMenu(data) async {
    return await apiMenuDatasourceImpl.getMenu(data);
  }

  @override
  Future<Menu> menuCreate(data) async {
    return await apiMenuDatasourceImpl.menuCreate(data);
  }
}
