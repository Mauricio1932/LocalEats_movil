import 'dart:convert';
import 'package:dio/dio.dart';

class LoginService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    try {
      Map<String, String> requestBody = {
        "name": username,
        "pass": password,
      };

      final response = await dio.post(
        'http://localhost:3000/api/login/login',
        data: jsonEncode(requestBody),
        options: Options(contentType: Headers.jsonContentType),
      );

      return {
        'status': response.statusCode,
        'data': response.data,
      };
    } catch (error) {
      return {
        'status': -1,
        'data': 'Error en la solicitud: $error',
      };
    }
  }
}