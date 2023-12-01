import 'package:bloc/bloc.dart';

import '../../../domain/usecase/get_mylocals_usecase.dart';
import 'my_bussines_event.dart';
import 'my_bussines_state.dart';

class MyBussinesBloc extends Bloc<MyBussinesEvent, MyBussinesState> {
  GetMyLocalUsecase getMyLocalUsecase;

  MyBussinesBloc(this.getMyLocalUsecase) : super(const MyBussinesState()) {
    on<GetBussinesRequest>(_handleGetMylocals);
  }

  Future<void> _handleGetMylocals(
    event,
    Emitter<MyBussinesState> emit,
  ) async {
    print("get_my_locals");
    try {
      emit(state.copyWith(
        bussinesStatus: MyBussinesRequest.unknown,
      ));

      final response = await getMyLocalUsecase.execute();

      emit(
        state.copyWith(
          bussinesStatus: MyBussinesRequest.requestSuccess,
          bussiness: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        bussinesStatus: MyBussinesRequest.requestFailure,
        bussiness: [],
      ));
    }
  }
}
