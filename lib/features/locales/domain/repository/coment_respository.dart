
import '../entities/coment_entities.dart';

abstract class ComentRepository{
  Future<List<Comentario>> getComentarios(id);
  Future<List<Comentario>> newComentario(id);
}