import 'package:bloc/bloc.dart';

import '../../../domain/usecase/create_user_case.dart';
import 'create_user_event.dart';
import 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateState> {
  final USerCreateUseCase useCaseCrearUserConfig;

  CreateUserBloc(this.useCaseCrearUserConfig) : super(const CreateState()) {
    on<CreateUserRequest>(_handleLoginUser);
  }

  Future<void> _handleLoginUser(event, Emitter<CreateState> emit) async {
    try {
      emit(state.copyWith(
        userStatus: UserRequest.requestInProgress,
      ));

      final response = await useCaseCrearUserConfig.execute(event.user);

      emit(
        state.copyWith(
          userStatus: UserRequest.requestSuccess,
          // user: response,
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      // print('Error during login: $error');

      emit(state.copyWith(
        userStatus: UserRequest.requestFailure,
      ));
    }
  }
}
