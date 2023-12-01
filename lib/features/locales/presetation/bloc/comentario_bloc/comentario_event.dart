import '../../../domain/entities/coment_entities.dart';

abstract class ComentarioEvent {
  const ComentarioEvent();
}

class GetCommentRequest extends ComentarioEvent {
  const GetCommentRequest(this.idPost);
  final Comentario idPost;
}

