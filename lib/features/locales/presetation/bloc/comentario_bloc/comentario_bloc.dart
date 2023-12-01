import 'package:bloc/bloc.dart';

import '../../../domain/usecase/get_coment_usecase.dart';
import 'comentario_event.dart';
import 'comentario_state.dart';

class ComentarioBloc extends Bloc<ComentarioEvent, ComentarioState> {
  final GetComentariosUseCase getComentariosUseCase;
  ComentarioBloc(this.getComentariosUseCase) : super(const ComentarioState()) {
    on<GetCommentRequest>(_handleGetComentarios);
  }

  Future<void> _handleGetComentarios(
    event,
    Emitter<ComentarioState> emit,
  ) async {
    try {
      emit(state.copyWith(
        postsStatus: CommentRequest.requestInProgress,
      ));

      final response = await getComentariosUseCase.execute(event.idPost);

      emit(
        state.copyWith(
          postsStatus: CommentRequest.requestSuccess,
          comentario: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        postsStatus: CommentRequest.requestFailure,
      ));
    }
  }
}
