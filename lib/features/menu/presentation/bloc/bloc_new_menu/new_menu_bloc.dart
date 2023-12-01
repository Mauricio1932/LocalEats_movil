import 'package:bloc/bloc.dart';
import 'package:localeats/features/menu/domain/usecase/create_menu_usecase.dart';
import 'package:localeats/features/menu/presentation/bloc/bloc_new_menu/new_menu_event.dart';
import 'package:localeats/features/menu/presentation/bloc/bloc_new_menu/new_menu_state.dart';

class NewMenuBloc extends Bloc<NewMenuEvent, NewMenuState> {
  PostMenuUsecase postMenuUsecase;
  NewMenuBloc(this.postMenuUsecase) : super(NewMenuState()) {
    on<PostPdfMenu>(_handleCreateLocal);
    on<ResetMenu>(_handleResetMenu);
  }

  Future<void> _handleCreateLocal(
    event, 
    Emitter<NewMenuState> emit) async {
    try {
      print("se ejecuto el bloc");
      emit(state.copyWith(
        newMenuStatus: NewMenuRequest.requestInProgress,
      ));

      final response = await postMenuUsecase.execute(event.data);
      
      emit(
        state.copyWith(
          newMenuStatus: NewMenuRequest.requestSuccess,
          menu: [response],
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      // print('Error during login: $error');

      emit(state.copyWith(
        newMenuStatus: NewMenuRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleResetMenu(
    event,
    Emitter<NewMenuState> emit,
  ) async {
    print("object reset");
    emit(state.copyWith(
      newMenuStatus: NewMenuRequest.unknown,
      // Otros campos del estado que podrían necesitar ser reseteados
    ));
  }
}
