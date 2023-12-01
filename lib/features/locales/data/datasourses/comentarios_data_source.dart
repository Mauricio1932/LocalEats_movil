import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:localeats/features/locales/data/models/comentario_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/coment_entities.dart';


abstract class ComentDataSource {
  Future<List<Comentario>> getComentarios(idPost);
  Future<List<Comentario>> newComentario(idPost);
}

class ApiComentDataSourceImpl implements ComentDataSource {
  Dio dio = Dio();
  String ip = '';
  final urlGetComentarios = "http://192.168.43.57:3001/api/comment/view?post_id=";
  final newCommentUrl = "http://192.168.43.57:3001/api/comment/create?post_id=";

  @override
  Future<List<Comentario>> getComentarios(idPost) async {
    final response = await http.get(Uri.parse(urlGetComentarios));

    print("object datasource ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final comentarios =
          body.map((dynamic item) => ComentarioModel.fromJson(item)).toList();

      return comentarios;
    } else {
      throw Exception('Failed to get coments');
    }
  }

  @override
  Future<List<Comentario>> newComentario(idPost) async {
    // Dio dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('name') ?? "";

    // final idUsers = sharedPreferences.getString('id_user') ?? '';

    // Reemplaza 'path_to_your_image' con la ruta real de tu imagen
    String token = sharedPreferences.getString('auth_token') ?? "";

    print("ejecuto datasourse: ${name}");
    

    try {
      Response response = await dio.post(
        '$newCommentUrl${idPost.post_id}',
        options: Options(
          headers: {
            'auth-token': token,
          },
        ),
        data: {
          'name': name,
          'comment': idPost.comment,
        },
      );

      if (response.statusCode == 200) {
        // Reemplaza 'NewPost.fromJson' con la lógica real para convertir la respuesta a una lista de NewPost
        List<Comentario> comentarioadd = response.data
            .map<Comentario>((post) => ComentarioModel.fromJson(post))
            .toList();
        return comentarioadd;
      } else {
        throw Exception('Failed to comment');
      }
    } catch (e) {
      throw Exception('Failed to $e');
    }
  }
}
