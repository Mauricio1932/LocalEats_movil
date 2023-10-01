// import 'dart:convert';
// import 'package:localeats/features/locales/data/models/local_model.dart';
// import 'package:http/http.dart' as http;
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../../domain/entities/login.dart';
import '../models/user_login_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDataSource {
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
  Future<List<UserLoginModel>> login(User user);
}

class ApiUserDatasourceImp implements UserDataSource {
  final String apiUrl = 'https://fakestoreapi.com/auth/login';
  final Dio dio = Dio();
  late SharedPreferences sharedPreferences;

  @override
  Future<List<UserLoginModel>> login(User user) async {
    Response response;

    try {
      response = await dio.post(
        apiUrl,
        data: {
          'username': user.username,
          'password': user.password,
        },
      );
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to log in");
    }

    if (response.statusCode == 200) {
      print("Status 200 OK");
      final token = response.data['token'];
      await saveAuthToken(token);

      return token; // Ahora el tipo de retorno es String
    } else {
      print("Error en el login, estado: ${response.statusCode}");
      throw Exception('Failed to log in');
    }
  }

  Future<void> saveAuthToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // Guardar el token en 'auth_token'
    await sharedPreferences.setString('auth_token', token);

    // Puedes imprimir el token para verificar que se haya guardado correctamente
    print("Token guardado: $token");
  }

  @override
  Future<void> removeAuthToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('auth_token');
  }

  // @override
  Future<String> getAuthToken() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("se ejecuto el token");
    final token = sharedPreferences.getString('auth_token') ?? '';
    // print("hay token? $token");
    return token;
  }
}
