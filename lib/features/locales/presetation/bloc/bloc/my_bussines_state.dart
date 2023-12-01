import 'package:localeats/features/locales/domain/entities/local.dart';


enum MyBussinesRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class MyBussinesState {
  const MyBussinesState({
    this.bussiness = const [],
    this.bussinesStatus = MyBussinesRequest.unknown,
    this.bussinessId = const {},
  });
  final List<Local> bussiness;
  final MyBussinesRequest bussinesStatus;
  final Set<int> bussinessId;

  MyBussinesState copyWith({
    List<Local>? bussiness,
    MyBussinesState? bussinesState, 
    Set<int>? bussinessId,
    required bussinesStatus,
  }) =>
      MyBussinesState(
        bussiness: bussiness ?? this.bussiness,
        bussinesStatus: bussinesStatus,
        bussinessId: bussinessId ?? this.bussinessId,
      );
}
