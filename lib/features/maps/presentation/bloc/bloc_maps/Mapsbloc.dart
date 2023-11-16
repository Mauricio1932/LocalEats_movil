import 'package:bloc/bloc.dart';
import 'package:localeats/features/maps/presentation/bloc/bloc_maps/maps_state.dart';

import '../../../domain/usecase/get_location_usecase.dart';
import 'maps_event.dart';

// import '../../../domain/usecase/create_user_case.dart';
// import 'create_user_event.dart';
// import 'create_user_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final GetLocationUsecase getLocationUsecase;

  MapsBloc(this.getLocationUsecase) : super(const MapsState()) {
    on<MapViewRequest>(_handleViewLocation);
  }

  Future<void> _handleViewLocation(
    event, 
    Emitter<MapsState> emit) async {
      print("al menos bloc");
    try {
      emit(state.copyWith(
        ubicacionStatus: MapRequest.requestInProgress,
      ));

      final response = await getLocationUsecase.execute(event.data);


      emit(
        state.copyWith(
          ubicacionStatus: MapRequest.requestSuccess,
          ubicacion: response,
        ),
      );
    } catch (error) {
      // Podrías hacer un manejo más específico de errores si es necesario
      print('Error during login: $error');

      emit(state.copyWith(
        ubicacionStatus: MapRequest.requestFailure,
      ));
    }
  }
}
