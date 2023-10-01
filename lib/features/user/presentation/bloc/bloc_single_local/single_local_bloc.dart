import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/locales/domain/usecase/get_single_local.dart';
// import 'package:localeats/features/user/presentation/bloc/bloc_locales/locales_event.dart';

import 'single_local_event.dart';
import 'single_local_state.dart';

class LocalesSingleBloc extends Bloc<LocalSingleEvent, LocalSingleState> {
  // final GetLocalUsecase getLocalUsecase;
  final GetSingleLocalUsecase getSingleLocalUsecase;

  LocalesSingleBloc(this.getSingleLocalUsecase)
      : super(const LocalSingleState()) {
    on<LocalSingleView>(_handleViewLocal);
    on<DeleteViewLocal>(_handleCloseViewLocal);
  }

  Future<void> _handleViewLocal(
    event,
    Emitter<LocalSingleState> emit,
  ) async {
    try {
      emit(state.copyWith(
        localesStatus: SingleRequest.requestInProgress,
      ));

      final response = await getSingleLocalUsecase.execute(event.localId);

      // print("Response de un local: ${response.title}");
      emit(state.copyWith(
        localesStatus: SingleRequest.requestSuccess,
        locales: [response],
      ));
    } catch (e) {
      emit(state.copyWith(
        localesStatus: SingleRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleCloseViewLocal(
    DeleteViewLocal event,
    Emitter<LocalSingleState> emit,
  ) async {
    emit(
      state.copyWith(
        localId: {...state.localId}..remove(event.localId), // Corregir aquí
        locales: null,
        localesStatus: SingleRequest.unknown,
      ),
    );
  }
}
