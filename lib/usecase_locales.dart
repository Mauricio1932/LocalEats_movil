

// import 'package:localeats/features/locales/domain/usecase/get_locales.dart';// caso de uso
// import 'features/locales/data/datasource/product_data_source.dart';
import 'features/locales/data/datasourses/locales_data_sourse.dart';
import 'features/locales/data/repositories/local_repository_impl.dart';
import 'features/locales/domain/usecase/get_local_usecases.dart';

class UsecaseLocalesConfig {
  ApiLocalDatasourceImp ? apiLocalDatasourceImp;
  // LocalApiDatasourceImp? localApiDataSourceImpl;
  LocalRepositoryImpl? localRepositoryImpl;
  GetLocalUsecase ? getLocalUsecase;

  UsecaseLocalesConfig(){
    apiLocalDatasourceImp = ApiLocalDatasourceImp();
    localRepositoryImpl = LocalRepositoryImpl(apiLocalDatasourceImp: apiLocalDatasourceImp!);
    getLocalUsecase = GetLocalUsecase(localRepositoryImpl!);
  }
  
}