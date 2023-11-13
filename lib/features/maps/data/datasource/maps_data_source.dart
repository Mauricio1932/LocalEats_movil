// http://localhost:3000/api/local/view_ubi_local?id=

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localeats/features/maps/data/models/maps_model.dart';

abstract class LocalApiDatasource {
  Future<List<MapsModel>> getUbicacion();
}

class ApiMapsDatasourceImp implements LocalApiDatasource {
  final String apiUrl = 'http://192.168.1.71:3000/api/local/viewAll';
  final String getSingleLocal =
      'http://192.168.1.71:3000/api/local/view_local/?id=';

  @override
  Future<List<MapsModel>> getUbicacion() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      final locals =
          body.map((dynamic item) => MapsModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }
}
