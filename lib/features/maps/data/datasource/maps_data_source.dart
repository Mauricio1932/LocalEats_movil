// http://localhost:3000/api/local/view_ubi_local?id=

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localeats/features/maps/data/models/maps_model.dart';

abstract class LocationApiDatasource {
  Future<List<MapsModel>> getUbicacion(data);
}

class ApiMapsDatasourceImp implements LocationApiDatasource {
  final String getSingleLocal ='http://10.11.2.252:3000/api/local/view_ubi_local?id=2';

  @override
  Future<List<MapsModel>> getUbicacion(data) async {
    final response = await http.get(Uri.parse(getSingleLocal));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> body = jsonDecode(response.body);

      final locals = body.map((dynamic item) => MapsModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }
}
