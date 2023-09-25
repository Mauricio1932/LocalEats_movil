import 'package:localeats/features/locales/domain/entities/local.dart';

class LocalModel extends Local {
  LocalModel({
    required int id,
    required String title,
    required String image,
  }) : super(id: id, title: title, image: image);

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
        id: json['id'], title: json['title'], image: json['image']);
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(id: local.id, title: local.title, image: local.image);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image};
  }
}
