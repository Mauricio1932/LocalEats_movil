import 'package:localeats/features/locales/domain/entities/local.dart';

//  "namelocal": "Ciudad Bocado",
//   "imagenn": "3.jpg",
//   "genero": "luis.cruz@gmail.com",
//   "descripcion": "1234",
//   "menu": "1234"
class LocalModel extends Local {
  LocalModel({
    required int id,
    required String namelocal,
    required String imagen,
    // required String price,
    required String genero,
    required String descripcion,
    required String menu,
  }) : super(
          id: id,
          namelocal: namelocal,
          imagen: imagen,
          // price: price,
          genero: genero,
          descripcion: descripcion,
          menu:menu,
        );

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
      id: json['id'],
      namelocal: json['namelocal'],
      imagen: json['imagen'],
      // price: json['price'],
      genero: json['genero'],
      descripcion: json['descripcion'],
      menu: json['menu'],
    );
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(
      id: local.id,
      namelocal: local.namelocal,
      imagen: local.imagen,
      // price: local.price,
      genero: local.genero,
      descripcion: local.descripcion,
      menu: local.menu
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namelocal': namelocal,
      'imagen': imagen,
      // 'price': price,
      'genero': genero,
      'descripcion': descripcion,
      'menu': menu,
    };
  }
}
