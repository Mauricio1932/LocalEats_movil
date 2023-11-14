import '../../../domain/entities/entities.dart';

enum MapRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class MapsState {
  const MapsState({
    this.ubicacion = const [],
    this.ubicacionStatus = MapRequest.unknown,
    // this.token = const {},
  });

  final List<Maps> ubicacion;
  final MapRequest ubicacionStatus;
  // final Set<String> token;

  MapsState copyWith({
    List<Maps>? ubicacion,
    MapsState? ubicacionState,
    // Set<String>? token,
    required ubicacionStatus,
  }) =>
      MapsState(
        ubicacion: ubicacion ?? this.ubicacion,
        ubicacionStatus: ubicacionStatus ?? this.ubicacionStatus,
      );
}
