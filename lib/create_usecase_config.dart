import 'features/user/data/datasource/user_data_source.dart';
import 'features/user/data/respositories/user_repository_impl.dart';
import 'features/user/domain/usecase/create_user_case.dart';

class UseCaseCrearUserConfig {
  ApiUserDatasourceImp? apiUserDatasourceImp;
  UserRepositoryImpl? userRepositoryImpl;

  USerCreateUseCase? uSerCreateUseCase;

  UseCaseCrearUserConfig() {
    apiUserDatasourceImp = ApiUserDatasourceImp();
    userRepositoryImpl = UserRepositoryImpl(apiUserDatasourceImp: apiUserDatasourceImp!);

    uSerCreateUseCase = USerCreateUseCase(userRepositoryImpl!);
  }
}
