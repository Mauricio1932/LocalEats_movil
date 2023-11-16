
import 'package:localeats/features/menu/domain/entities/entities.dart';

class MenuModel extends Menu {
  MenuModel({
    required int id,
    required String pdf,
  }) : super(
          id: id,
          pdf: pdf,
        );

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      pdf: json['pdf'],
    );
  }

  factory MenuModel.fromEntity(Menu maps) {
    return MenuModel(
      id: maps.id,
      pdf: maps.pdf,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pdf': pdf,
    };
  }
}
