
import '../../domain/entities/coment_entities.dart';

class  ComentarioModel extends Comentario {
  ComentarioModel({
    required int post_id,
    required String name,
    required String comment
    // required String description,
  }) : super(
          post_id: post_id,
          name: name,
          comment: comment
          // // description: description,
        );

  factory ComentarioModel.fromJson(Map<String, dynamic> json) {
    return ComentarioModel(
      post_id: json['post_id'],
      name: json['name'],
      comment: json['comment'],
      // // description: json['description'],
    );
  }

  factory ComentarioModel.fromEntity(Comentario post) {
    return ComentarioModel(
      post_id: post.post_id,
      name: post.name,
      comment: post.comment
      // // description: post.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'name': name,
      'comment': comment
      // // 'description': description,
    };
  }
}
