import 'features/maps/data/datasource/maps_data_source.dart';
import 'features/maps/data/repositories/maps_respository_impl.dart';
import 'features/maps/domain/usecase/get_location_usecase.dart';

class UsecaseMapsConfig {
  ApiMapsDatasourceImp ? apiMapsDatasourceImp;
  MapsRepositoryImpl? mapsRepositoryImpl;

  GetLocationUsecase? getLocationUsecase;

  UsecaseMapsConfig() {
    apiMapsDatasourceImp = ApiMapsDatasourceImp();
    mapsRepositoryImpl = MapsRepositoryImpl(apiMapsDatasourceImp: apiMapsDatasourceImp!);

    getLocationUsecase = GetLocationUsecase(mapsRepositoryImpl!);
  }
}
