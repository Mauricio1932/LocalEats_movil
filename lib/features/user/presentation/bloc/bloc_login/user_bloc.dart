import 'package:bloc/bloc.dart';
import 'package:localeats/features/user/domain/usecase/getTokenUsecase.dart';

import '../../../domain/usecase/delete_token_usecase.dart';
import '../../../domain/usecase/login_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUserUsecase loginUserUsecase;
  final GetAuthTokenUseCase getAuthTokenUseCase;
  final RemoveTokenUseCase removeTokenUseCase;

  UserBloc(
      this.loginUserUsecase, this.getAuthTokenUseCase, this.removeTokenUseCase)
      : super(const UserState()) {
    on<LoginUserRequest>(_handleLoginUser);
    on<GetAuthToken>(_handleGetToken);
    on<RemoveAuthToken>(_handleDeleteToken);
  }

  Future<void> _handleLoginUser(event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(
        userStatus: UserRequest.requestInProgress,
      ));

      final response = await loginUserUsecase.execute(event.user);

      emit(
        state.copyWith(
          userStatus: UserRequest.requestSuccess,
          user: response,
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      print('Error during login: $error');

      emit(state.copyWith(
        userStatus: UserRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleGetToken(
    event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(
        userStatus: UserRequest.requestInProgress,
      ));

      // var tokenFuture =
      var token = await getAuthTokenUseCase.execute(); // Esto es un Future<String>
      

      if (token == '') {
        emit(state.copyWith(
          userStatus: UserRequest.requestFailure,
        ));
      } else {
        emit(state.copyWith(
          userStatus: UserRequest.requestSuccess,
          token: {token},
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        userStatus: UserRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleDeleteToken(
    event,
    Emitter<UserState> emit,
  ) async {
    print("(Se ejecuto el removej)");

    try {
      emit(state.copyWith(
        userStatus: UserRequest.requestInProgress,
      ));

      removeTokenUseCase.execute();

      // Después de obtener el token, puedes emitir un nuevo estado
      emit(state.copyWith(
        userStatus: UserRequest.requestSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        userStatus: UserRequest.requestFailure,
      ));
    }
  }
}
