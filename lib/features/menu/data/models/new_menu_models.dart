
import 'dart:io';


import '../../domain/entities/new_menu_entities.dart';

class NewMenuModel extends NewMenu {
  NewMenuModel({
    required File pdf,
    required int id,
  }) : super(
          pdf: pdf,
          id: id,
        );

  factory NewMenuModel.fromJson(Map<String, dynamic> json) {
    return NewMenuModel(
      pdf: json['pdf'],
      id: json['id'],
    );
  }

  factory NewMenuModel.fromEntity(NewMenu newmenu) {
    return NewMenuModel(
      pdf: newmenu.pdf,
      id: newmenu.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pdf': pdf,
      'id': id,
    };
  }
}
