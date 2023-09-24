import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locales/domain/usecase/get_local_usecases.dart';
import 'locales_event.dart';
import 'locales_state.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final GetLocalUsecase getLocalUsecase;

  LocalesBloc(this.getLocalUsecase) : super(const LocalesState()) {
    on<LocalRequest>(_handleLocalesRecuested);
    on<LocalView>(_handleViewLocal);
  }

  // final LocalesRepository api = LocalesRepository();

  Future<void> _handleLocalesRecuested(
    LocalRequest event,

    Emitter<LocalesState> emit,
  ) async {
    try {

      emit(state.copyWith(
        localesStatus: LocalesRequest.requestInProgress,
      ));

      final response = await getLocalUsecase.execute();
      // final response = await api.getProducts();
        // print(response);

      emit(state.copyWith(
        localesStatus: LocalesRequest.requestSuccess,
        locales: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleViewLocal(
    LocalView event,
    Emitter<LocalesState> emit,
  ) async {
    emit(
      state.copyWith(
        localId: {...state.localId, event.localId},
        localesStatus: null,
      ),
    );
  }
}
