// http://localhost:3000/api/local/view_ubi_local?id=

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:localeats/features/locales/data/models/new_local_entities.dart';
import 'package:localeats/features/locales/domain/entities/local.dart';
import 'package:localeats/features/maps/data/models/maps_model.dart';
import 'package:localeats/features/menu/data/models/new_menu_models.dart';
import 'package:localeats/features/menu/domain/entities/new_menu_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/menu_model.dart';

Dio dio = Dio();

abstract class MenuApiDatasource {
  Future<List<MenuModel>> getMenu(data);
  Future<MenuModel> menuCreate(NewMenu data);
}

class ApiMenuDatasourceImpl implements MenuApiDatasource {
  final String getSingleLocal =
      'http://192.168.43.57:3000/api/menu/viewAllMenu?localId=';
  final String newMenuCreate = 'http://192.168.43.57:3000/api/menu/createMenu';

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

  @override
  Future<MenuModel> menuCreate(NewMenu newLocal) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // final idUser = sharedPreferences.getString('id_user') ?? '';
    final token = sharedPreferences.getString('auth_token') ?? '';

    String fileName = newLocal.pdf.path.split('/').last;
    FormData formData = FormData.fromMap(
      {
        'pdf': await MultipartFile.fromFile(newLocal.pdf.path, filename: fileName),
        'localId': newLocal.id,
      },
    );
    print("response ${formData.fields}");

    try {
      print("se ejecuto el dtaa source");
      Response response = await dio.post(
        newMenuCreate,
        options: Options(
          headers: {
            'auth-token': token,
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        // Reemplaza 'NewPost.fromJson' con la lógica real para convertir la respuesta a un objeto LocalModel
        MenuModel newLocal = MenuModel.fromJson(response.data);

        return newLocal;
      } else {
        throw Exception('Failed to create local');
      }
    } catch (e) {
      throw Exception('Failed to  $e');
    }
  }
}
