
// import '../../../domain/entities/user.dart';

import 'package:localeats/features/maps/domain/entities/entities.dart';

abstract class MapsEvent {
  const MapsEvent();
}

class MapViewRequest extends MapsEvent {
  const MapViewRequest(this.data);
  final Maps data;
}

