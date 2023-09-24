import 'package:localeats/features/locales/domain/entities/local.dart';

class LocalModel extends Local {
  LocalModel({
    required int id,
    required String title,
    required String urlImage,
  }) : super(id: id, title: title, urlImage: urlImage);

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
        id: json['id'], title: json['title'], urlImage: json['urlImage']);
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(
        id: local.id, title: local.title, urlImage: local.urlImage);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'urlImage': urlImage};
  }
}
