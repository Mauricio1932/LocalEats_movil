// import 'package:flutter/widgets.dart';

import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';
import 'package:localeats/features/user/presentation/pages/create_local.dart';

import '../entities/local.dart';

abstract class LocalRepository {
  // Future<void> postAddProduct(Local);
  // Future<void> putUpdateProduct(String productId);
  // Future<void> deleteProduct(String productId);

  Future<List<Local>> getLocals();
  Future<List<Local>> getSingleLocals(int localId);
  Future<Local> createLocal(NewLocal localId);
}
