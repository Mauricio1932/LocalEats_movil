import '../../domain/entities/entities.dart';

class MapsModel extends Maps {
  MapsModel({
    required String ubicacion,
  }) : super(
          ubicacion: ubicacion,
        );

  factory MapsModel.fromJson(Map<String, dynamic> json) {
    return MapsModel(
      ubicacion: json['ubicacion'],
    );
  }

  factory MapsModel.fromEntity(Maps maps) {
    return MapsModel(
      ubicacion: maps.ubicacion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ubicacion': ubicacion,
    };
  }
}
