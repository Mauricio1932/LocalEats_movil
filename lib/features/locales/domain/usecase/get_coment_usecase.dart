
// ignore_for_file: use_rethrow_when_possible, avoid_print

import '../entities/coment_entities.dart';
import '../repository/coment_respository.dart';

class GetComentariosUseCase {
  final ComentRepository postRepository;

  GetComentariosUseCase(this.postRepository);

  Future<List<Comentario>> execute(idPost) async {
    try {
      final comentario = await postRepository.getComentarios(idPost);

      // ignore: unnecessary_null_comparison
      if (comentario != null) {
        // print("$comentario");
        return comentario;
      } else {
        throw Exception('No se pudo obtener los posts');
      }
    } catch (e) {
      print("Error use case $e");
      throw (e);
    }
  }
}
