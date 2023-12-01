import '../../domain/entities/coment_entities.dart';
import '../../domain/repository/coment_respository.dart';
import '../datasourses/comentarios_data_source.dart';

class ComentRepositoryImpl implements ComentRepository {
  final ApiComentDataSourceImpl apiComentDataSourceImpl;

  ComentRepositoryImpl({required this.apiComentDataSourceImpl});

  @override
  Future<List<Comentario>> getComentarios(idPost) async {
    return await apiComentDataSourceImpl.getComentarios(idPost);
  }

  @override
  Future<List<Comentario>> newComentario(idPost) async {
    return await apiComentDataSourceImpl.newComentario(idPost);
  }
}
