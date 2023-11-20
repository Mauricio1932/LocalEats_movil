import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:localeats/features/locales/data/models/local_model.dart';
import 'package:http/http.dart' as http;
import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/new_local_entities.dart';

abstract class LocalApiDatasource {
  Future<List<LocalModel>> getLocals();
  Future<List<LocalModel>> getSingleLocals(int local);
  Future<LocalModel> createLocal(NewLocal product);
  // Future<void> putUpdateProduct(Local product);
  // Future<void> deleteProduct(String id);
}

class ApiLocalDatasourceImp implements LocalApiDatasource {
  Dio dio = Dio();

  final String apiUrl = 'http://192.168.1.69:3000/api/local/viewAll';
  final String getSingleLocal =
      'http://192.168.1.69:3000/api/local/viewLocalById/?id=';
  final String create_local = "http://192.168.1.69:3000/api/local/createLocal";
  @override
  Future<List<LocalModel>> getLocals() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
          List<dynamic> body = jsonDecode(response.body);

          final locals =
              body.map((dynamic item) => LocalModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<List<LocalModel>> getSingleLocals(int local) async {
    // final response = await http.get(Uri.parse('$getSingleLocal/$local'));
    print('url  $getSingleLocal$local');
    final response = await http.get(Uri.parse('$getSingleLocal$local'));

    // print("petcion ${local}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      final local =
          body.map((dynamic item) => LocalModel.fromJson(item)).toList();

      return local;
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Future<LocalModel> createLocal(NewLocal newLocal) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final idUser = sharedPreferences.getString('id_user') ?? '';
    final token = sharedPreferences.getString('auth_token') ?? '';

    String fileName = newLocal.imagen2.path.split('/').last;
    FormData formData = FormData.fromMap(
      {
        'namelocal': newLocal.namelocal,
        'imagen': await MultipartFile.fromFile(newLocal.imagen2.path,
            filename: fileName),
        'genero': newLocal.genero,
        'descripcion': newLocal.descripcion,
        'ubicacion': newLocal.ubicacion,
        'menu': newLocal.menu,
        'userId': idUser,
      },
    );
    print("response ${formData.fields}");

    try {
      Response response = await dio.post(
        create_local,
        options: Options(
          headers: {
            'auth-token': token,
          },
        ),
        data: formData,
      );
      print("status: ${response.statusCode}");
      if (response.statusCode == 200) {
        print('Respuesta del servidor: ${response.data}');

        // Reemplaza 'NewPost.fromJson' con la lógica real para convertir la respuesta a un objeto LocalModel
        LocalModel newLocal = LocalModel.fromJson(response.data);

        return newLocal;
      } else {
        throw Exception('Failed to create local');
      }
    } catch (e) {
      throw Exception('Failed to  $e');
    }
  }

  // @override
  // Future<void> putUpdateProduct(Product product) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   String productsString = sharedPreferences.getString('product') ?? "[]";
  //   List<ProductModel> productModel = jsonDecode(productsString).map<ProductModel>((data) => ProductModel.fromJson(data)).toList();

  //   productModel.removeWhere((item) => item.id == product.id);
  //   productModel.add(UserModel.fromEntity(product as User) as ProductModel);
  //   sharedPreferences.setString('product', jsonEncode(product));
  // }
}
