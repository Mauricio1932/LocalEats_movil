import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/locales/domain/usecase/get_mylocals_usecase.dart';
// import 'package:localeats/features/locales/domain/usecase/get_single_local.dart';

// import '../../../locales/domain/usecase/get_local_usecases.dart';
import '../../../../locales/domain/usecase/get_local_usecases.dart';
import 'locales_event.dart';
import 'locales_state.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final GetLocalUsecase getLocalUsecase;
  // final GetMyLocalUsecase getMyLocalUsecase;
  LocalesBloc(this.getLocalUsecase) : super(const LocalesState()) {
    on<LocalGetRequest>(_handleLocalesRecuested);
    on<ReseteLocal>(_handleReset);
   
  }

  Future<void> _handleLocalesRecuested(
    event,
    Emitter<LocalesState> emit,
  ) async {
    try {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestInProgress,
      ));

      final response = await getLocalUsecase.execute();

      emit(
        state.copyWith(
          localesStatus: LocalesRequest.requestSuccess,
          locales: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleReset(
    event,
    Emitter<LocalesState> emit,
  ) async {
    print("object reset");
    emit(state.copyWith(
      localesStatus: LocalesRequest.unknown,
      // Otros campos del estado que podrían necesitar ser reseteados
    ));
  }
  // Future<void> _handleViewLocal(
  //   event,
  //   Emitter<LocalesState> emit,
  // ) async {
  //   try {
  //     emit(state.copyWith(
  //       localesStatus: LocalesRequest.requestInProgress,
  //     ));

  //     final response = await getSingleLocalUsecase.execute(event.localId);

  //     // print("Response de un local: ${response.title}");
  //     emit(state.copyWith(
  //       localesStatus: LocalesRequest.requestSuccess,
  //       locales: [response],
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       localesStatus: LocalesRequest.requestFailure,
  //     ));
  //   }
  // }

  // Future<void> _handleViewLocal(
  //   LocalSingleView event,
  //   Emitter<LocalesState> emit,
  // ) async {
  //   try {
  //     // emit(
  //     //   state.copyWith(
  //     //     localId: {...state.localId, event.localId},
  //     //     localesStatus: null,
  //     //   ),
  //     // );
  //     // print("presione el evento view local");
  //     final response = await getSingleLocalUsecase.execute(event.localId);
  //     // print("response ${response.category}");

  //     emit(state.copyWith(
  //       localesStatus: LocalesRequest.requestSuccess,
  //       locales: response,
  //     ));

  //   } catch (e) {
  //     print("tienes este error:$e");
  //   }
  // }

  // Future<void> _handleCloseViewLocal(
  //   DeleteLocalSingleView event,
  //   Emitter<LocalesState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(
  //       localId: {...state.localId}..remove(event.localId), // Corregir aquí
  //       localesStatus: null,
  //     ),
  //   );
  // }
}
