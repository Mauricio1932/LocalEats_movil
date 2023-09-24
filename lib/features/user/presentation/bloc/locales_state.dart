import '../../../locales/domain/entities/local.dart';

enum LocalesRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure
}

class LocalesState {
  const LocalesState({
    this.locales = const [],
    this.localesStatus = LocalesRequest.unknown,
    this.localId = const {},
  });

  final List<Local> locales;
  final LocalesRequest localesStatus;
  final Set<int> localId;

  LocalesState copyWith({
    List<Local>? locales,
    LocalesState? localesState,
    Set<int>? localId, required localesStatus,
  }) =>
      LocalesState(
        locales: locales ?? this.locales,
        localesStatus: localesStatus ?? this.localesStatus,
        localId: localId ?? this.localId,
      );
}
