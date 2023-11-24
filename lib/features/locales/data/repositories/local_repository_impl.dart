import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';

import '../../domain/entities/local.dart';
import '../../domain/repository/locales_repository.dart';
import '../datasourses/locales_data_sourse.dart';

class LocalRepositoryImpl implements LocalRepository {
  final ApiLocalDatasourceImp apiLocalDatasourceImp;

  LocalRepositoryImpl({required this.apiLocalDatasourceImp});

  @override
  Future<List<Local>> getLocals() async {
    return await apiLocalDatasourceImp.getLocals();
  }

  // @override
  // Future<List<Local>> getSingleLocals(int local) async {
  //   return await apiLocalDatasourceImp.getSingleLocals(local);
  // }

  @override
  Future<List<Local>> getSingleLocals(int localId) async {
    return await apiLocalDatasourceImp.getSingleLocals(localId);
  }

  @override
  Future<List<Local>> getMyLocals() async {
    return await apiLocalDatasourceImp.getMyLocals();
  }

  @override
  Future<Local> createLocal(NewLocal local) async {
    return await apiLocalDatasourceImp.createLocal(local);
  }

  // @override
  // Future<String> updateLocal(Local local) async {
  //   return await userLocalDataSource.updateLocal(local);
  // }

  // @override
  // Future<String> deleteLocal(String id) async {
  //   return await userLocalDataSource.deleteLocal(id);
  // }
}
