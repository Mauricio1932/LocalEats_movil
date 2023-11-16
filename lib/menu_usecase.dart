import 'features/menu/data/datasource/menu_data_source.dart';
import 'features/menu/data/repositories/maps_respository_impl.dart';
import 'features/menu/domain/usecase/get_menu_usecase.dart';

class MenuCaseUserConfig {
  ApiMenuDatasourceImpl? apiMenuDatasourceImpl;
  MenuRepositoryImpl? menuRepositoryImpl;

  GetMenuUsecase? getMenuUsecase;

  MenuCaseUserConfig() {
    apiMenuDatasourceImpl = ApiMenuDatasourceImpl();
    menuRepositoryImpl =
        MenuRepositoryImpl(apiMenuDatasourceImpl: apiMenuDatasourceImpl!);

    getMenuUsecase = GetMenuUsecase(menuRepositoryImpl!);
  }
}
