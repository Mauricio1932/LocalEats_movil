// import '../../../locales/domain/entities/local.dart';

import '../../../../locales/domain/entities/local.dart';

enum SingleRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure
}

class LocalSingleState {
  const LocalSingleState({
    this.locales = const [],
    this.localesStatus = SingleRequest.unknown,
    this.localId = const {},
  });

  final List<Local> locales;
  final SingleRequest localesStatus;
  final Set<int> localId;

  LocalSingleState copyWith({
    List<Local>? locales,
    LocalSingleState? localSingleState,
    Set<int>? localId,
    required localesStatus,
  }) =>
      LocalSingleState(
        locales: locales ?? this.locales,
        localesStatus: localesStatus ?? this.localesStatus,
        localId: localId ?? this.localId,
      );
}


