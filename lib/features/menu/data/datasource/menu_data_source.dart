// http://localhost:3000/api/local/view_ubi_local?id=

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localeats/features/maps/data/models/maps_model.dart';

import '../models/menu_model.dart';

abstract class LocationApiDatasource {
  Future<List<MenuModel>> getMenu(data);
}

class ApiMenuDatasourceImpl implements LocationApiDatasource {
  final String getSingleLocal =
      'http://10.11.1.158:3000/api/menu/viewAllMenu?localId=';

  @override
  Future<List<MenuModel>> getMenu(data) async {
    final response = await http.get(Uri.parse('$getSingleLocal${data.id}'));

  
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> body = jsonDecode(response.body);

      final locals =
          body.map((dynamic item) => MenuModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }
}
