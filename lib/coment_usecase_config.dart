

import 'features/locales/data/datasourses/comentarios_data_source.dart';
import 'features/locales/data/repositories/coment_repository_impl.dart';
import 'features/locales/domain/usecase/get_coment_usecase.dart';

class UseCaseComentarioConfig {
  ApiComentDataSourceImpl? apiComentDataSourceImpl;
  ComentRepositoryImpl? postRepositoryImpl;

  GetComentariosUseCase? getComentariosUseCase;
  // NewComentarioUseCase? newComentarioUseCase;
  
  UseCaseComentarioConfig() {
    apiComentDataSourceImpl = ApiComentDataSourceImpl();
    postRepositoryImpl =
    ComentRepositoryImpl(apiComentDataSourceImpl: apiComentDataSourceImpl!);

    getComentariosUseCase = GetComentariosUseCase(postRepositoryImpl!);
    // newComentarioUseCase = NewComentarioUseCase(postRepositoryImpl!);
  }
}
