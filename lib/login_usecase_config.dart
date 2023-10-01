import 'features/user/data/datasource/user_data_source.dart';
import 'features/user/data/respositories/user_repository_impl.dart';
import 'features/user/domain/usecase/delete_token_usecase.dart';
import 'features/user/domain/usecase/getTokenUsecase.dart';
import 'features/user/domain/usecase/login_usecase.dart';

class UseCaseUserConfig {
  ApiUserDatasourceImp? apiUserDatasourceImp;
  UserRepositoryImpl? userRepositoryImpl;

  LoginUserUsecase? loginUserUsecase;
  GetAuthTokenUseCase? getAuthTokenUseCase;
  RemoveTokenUseCase? removeTokenUseCase;

  UseCaseUserConfig() {
    apiUserDatasourceImp = ApiUserDatasourceImp();
    userRepositoryImpl = UserRepositoryImpl(apiUserDatasourceImp: apiUserDatasourceImp!);

    loginUserUsecase = LoginUserUsecase(userRepositoryImpl!);
    getAuthTokenUseCase = GetAuthTokenUseCase(userRepositoryImpl!);
    removeTokenUseCase = RemoveTokenUseCase(userRepositoryImpl!);
  }
}
