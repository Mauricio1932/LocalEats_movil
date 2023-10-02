import 'features/locales/data/datasourses/locales_data_sourse.dart';
import 'features/locales/data/repositories/local_repository_impl.dart';
import 'features/locales/domain/usecase/get_local_usecases.dart';
import 'features/locales/domain/usecase/get_single_local.dart';

class UsecaseLocalesConfig {
  ApiLocalDatasourceImp? apiLocalDatasourceImp;
  LocalRepositoryImpl? localRepositoryImpl;

  GetLocalUsecase? getLocalUsecase;
  GetSingleLocalUsecase? getSingleLocalUsecase;

  UsecaseLocalesConfig() {
    apiLocalDatasourceImp = ApiLocalDatasourceImp();
    localRepositoryImpl = LocalRepositoryImpl(apiLocalDatasourceImp: apiLocalDatasourceImp!);

    getLocalUsecase = GetLocalUsecase(localRepositoryImpl!);
    getSingleLocalUsecase = GetSingleLocalUsecase(localRepositoryImpl!);
    
  }
}
