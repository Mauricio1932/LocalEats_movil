import '../../../domain/entities/coment_entities.dart';

enum CommentRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class ComentarioState {
  const ComentarioState({
    this.comentario = const [],
    this.commentStatus = CommentRequest.unknown,
    this.comentarioId = const {},
  });
  final List<Comentario> comentario;
  final CommentRequest commentStatus;
  final Set<int> comentarioId;

  ComentarioState copyWith({
    List<Comentario>? comentario,
    ComentarioState? comentState, 
    Set<int>? comentarioId,
    required postsStatus,
  }) =>
      ComentarioState(
        comentario: comentario ?? this.comentario,
        commentStatus: commentStatus,
        comentarioId: comentarioId ?? this.comentarioId,
      );
}
