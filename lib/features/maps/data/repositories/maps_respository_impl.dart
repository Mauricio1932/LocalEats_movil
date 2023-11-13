// import '../../domain/entities/local.dart';
// import '../../domain/repository/locales_repository.dart';
// import '../datasourses/locales_data_sourse.dart';


import 'package:localeats/features/maps/domain/entities/entities.dart';

import '../../domain/repository/maps_repository.dart';
import '../datasource/maps_data_source.dart';

class MapsRepositoryImpl implements MapsRepository {
  final ApiMapsDatasourceImp apiMapsDatasourceImp;

  MapsRepositoryImpl({required this.apiMapsDatasourceImp});

  @override
  Future<List<Maps>> getUbicacion() async {
    return await apiMapsDatasourceImp.getUbicacion();
  }
}
