import 'package:bloc/bloc.dart';
import 'package:localeats/features/maps/presentation/bloc/bloc_maps/maps_state.dart';
import 'package:localeats/features/menu/presentation/bloc/bloc_menu/menu_state.dart';

import '../../../domain/usecase/get_menu_usecase.dart';
import 'menu_event.dart';

// import '../../../domain/usecase/create_user_case.dart';
// import 'create_user_event.dart';
// import 'create_user_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetMenuUsecase getMenuUsecase;

  MenuBloc(this.getMenuUsecase) : super(const MenuState()) {
    on<GetPdfMenu>(_handleViewLocation);
  }

  Future<void> _handleViewLocation(event, Emitter<MenuState> emit) async {
    print("al menos bloc");
    try {
      emit(state.copyWith(
        menuStatus: MenuRequest.requestInProgress,
      ));

      final response = await getMenuUsecase.execute(event.data);

      emit(
        state.copyWith(
          menuStatus: MenuRequest.requestSuccess,
          menu: response,
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      print('Error during menu: $error');

      emit(state.copyWith(
        menuStatus: MenuRequest.requestFailure,
      ));
    }
  }
}
