import 'package:localeats/features/locales/domain/entities/local.dart';

class LocalModel extends Local {
  LocalModel({
    required int id,
    required String title,
    required String image,
    // required String price,
    required String description,
    required String category,
  }) : super(
          id: id,
          title: title,
          image: image,
          // price: price,
          description: description,
          category: category,
        );

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      // price: json['price'],
      description: json['description'],
      category: json['category'],
    );
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(
      id: local.id,
      title: local.title,
      image: local.image,
      // price: local.price,
      description: local.description,
      category: local.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      // 'price': price,
      'description': description,
      'category': category,
    };
  }
}
