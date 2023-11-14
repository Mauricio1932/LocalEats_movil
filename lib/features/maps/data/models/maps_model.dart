import '../../domain/entities/entities.dart';

class MapsModel extends Maps {
  MapsModel({
    required int id,
    required String ubicacion,
  }) : super(
          id: id,
          ubicacion: ubicacion,
        );

  factory MapsModel.fromJson(Map<String, dynamic> json) {
    return MapsModel(
      id: json['id'],
      ubicacion: json['ubicacion'],
    );
  }

  factory MapsModel.fromEntity(Maps maps) {
    return MapsModel(
      id: maps.id,
      ubicacion: maps.ubicacion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ubicacion': ubicacion,
    };
  }
}
