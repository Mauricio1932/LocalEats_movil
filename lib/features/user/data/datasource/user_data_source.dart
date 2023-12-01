// import 'dart:convert';
// import 'package:localeats/features/locales/data/models/local_model.dart';
// import 'package:http/http.dart' as http;
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/user.dart';
import '../models/create_user_model.dart';
import '../models/user_login_model.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDataSource {
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
  Future<List<UserLoginModel>> login(User user);
  Future<CreateUserLoginModel> userCreate(UserCreate user);
}

class ApiUserDatasourceImp implements UserDataSource {
  final String apiUrl = 'http://192.168.43.57:3000/api/login/login';
  final String userUrl = 'http://192.168.43.57:3000/api/login/create';

  final Dio dio = Dio();
  late SharedPreferences sharedPreferences;

  @override
  Future<List<UserLoginModel>> login(User user) async {
    Response response;

    try {
      response = await dio.post(
        apiUrl,
        data: {
          'name': user.username,
          'pass': user.password,
        },
      );
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to log in");
    }

    print('token ${response.data}');
    if (response.statusCode == 200) {
      print("Status 200 OK");
      final token = response.data['data']['token'];
      final idUser = response.data['data']['id'];
      final name = response.data['data']['name'];
      await saveAuthToken(token, idUser, name);
      return token; // Ahora el tipo de retorno es String
    } else {
      print("Error en el login, estado: ${response.statusCode}");
      throw Exception('Failed to log in');
    }
  }

  Future<void> saveAuthToken(String token, String idUser, String name) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // Guardar el token en 'auth_token'
    await sharedPreferences.setString('auth_token', token);
    await sharedPreferences.setString('id_user', idUser);
    await sharedPreferences.setString('name', name);

    // Puedes imprimir el token para verificar que se haya guardado correctamente
    print("Token guardado: $token, $name");
  }

  @override
  Future<void> removeAuthToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.remove('auth_token');
    await sharedPreferences.remove('id_user');
    await sharedPreferences.remove('name');
  }

  @override
  Future<String> getAuthToken() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    print("se ejecuto el token");
    final token = sharedPreferences.getString('auth_token') ?? '';
    // print("hay token? $token");
    return token;
  }

  @override
  Future<CreateUserLoginModel> userCreate(UserCreate user) async {
    Response response;
    print("object");
    try {
      response = await dio.post(
        userUrl,
        data: {
          'name': user.name,
          'pass': user.pass,
          'email': user.email,
          'telefono': user.telefono,
        },
      );
      print("Respinse $response");
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to log in");
    }
    if (response.statusCode == 200) {
      print("Status 201 OK");
      // final token = response.data['token'];

      // await saveAuthToken(token);
      // List<dynamic> body = jsonDecode(response.data);
      CreateUserLoginModel newLocal =
          CreateUserLoginModel.fromJson(response.data);

      return newLocal;
      // return response.data; // Ahora el tipo de retorno es String
    } else {
      print("Error en el login, estado: ${response.statusCode}");
      throw Exception('Failed to log in');
    }
  }
}
