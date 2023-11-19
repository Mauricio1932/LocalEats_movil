import 'package:bloc/bloc.dart';

import '../../../../locales/domain/usecase/post_newlocal_usecase.dart';
import 'create_local_event.dart';
import 'create_local_state.dart';

class CreateLocalBloc extends Bloc<CreateLocalEvent, CreateLocalState> {
  PostNewLocalUsecase postNewLocalUsecase;
  CreateLocalBloc(this.postNewLocalUsecase) : super(CreateLocalState()) {
    on<CreateLocalRequest>(_handleCreateLocal);
  }

  Future<void> _handleCreateLocal(
    event,
    Emitter<CreateLocalState> emit) async {
      print("se ejecuto");
    
    try {
      emit(state.copyWith(
        newLocalStatus: LocalRequest.requestInProgress,
      ));

      final response = await postNewLocalUsecase.execute(event.data);

      emit(
        state.copyWith(
          newLocalStatus: LocalRequest.requestSuccess,
          newLocals: [response],
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      // print('Error during login: $error');

      emit(state.copyWith(
        newLocalStatus: LocalRequest.requestFailure,
      ));
    }
  }
}
