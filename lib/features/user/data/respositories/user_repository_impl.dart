import '../../domain/entities/login.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/user_data_source.dart';

class UserRepositoryImpl implements LoginUserRepository {
  final ApiUserDatasourceImp apiUserDatasourceImp;

  UserRepositoryImpl({required this.apiUserDatasourceImp});

  @override
  Future<List<User>> login(User user) async {
    return await apiUserDatasourceImp.login(user);
  }

  @override
  Future<void> removeAuthToken() {
    return apiUserDatasourceImp.removeAuthToken();
  }

  @override
  Future<String> getAuthToken() {
    return apiUserDatasourceImp.getAuthToken();
  }

  @override
  Future<List<UserCreate>>userCreate(UserCreate user) {
    return apiUserDatasourceImp.userCreate(user);
  }
}
