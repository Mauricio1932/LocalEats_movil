import 'dart:io';

import '../../domain/entities/new_local_entities.dart';

class NewLocalModel extends NewLocal {
  NewLocalModel({
    required int id,
    required String namelocal,
    required String imagen,
    required File imagen2,
    required String genero,
    required String descripcion,
    required String ubicacion,
    required String menu,
  }) : super(
          id: id,
          namelocal: namelocal,
          imagen: imagen,
          imagen2: imagen2,
          genero: genero,
          descripcion: descripcion,
          ubicacion: ubicacion,
          menu: menu,
        );

  factory NewLocalModel.fromJson(Map<String, dynamic> json) {
    return NewLocalModel(
      id: json['id'],
      namelocal: json['namelocal'],
      imagen: json['imagen'],
      imagen2: json['imagen2'],
      genero: json['genero'],
      descripcion: json['descripcion'],
      ubicacion: json['ubicacion'],
      menu: json['menu'],
    );
  }

  factory NewLocalModel.fromEntity(NewLocal local) {
    return NewLocalModel(
      id: local.id,
      namelocal: local.namelocal,
      imagen: local.imagen,
      imagen2: local.imagen2,
      genero: local.genero,
      descripcion: local.descripcion,
      ubicacion: local.ubicacion,
      menu: local.menu,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namelocal': namelocal,
      'imagen': imagen,
      'imagen2': imagen2,
      'genero': genero,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'menu': descripcion,
    };
  }
}
