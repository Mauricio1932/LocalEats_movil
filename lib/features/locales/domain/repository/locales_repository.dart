import '../entities/local.dart';

abstract class LocalRepository {
  // Future<void> postAddProduct(Local);
  // Future<void> putUpdateProduct(String productId);
  // Future<void> deleteProduct(String productId);

  Future<List<Local>> getLocals();

}