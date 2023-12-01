import 'package:localeats/features/locales/domain/entities/local.dart';

abstract class MyBussinesEvent {
  const MyBussinesEvent();
}

class GetBussinesRequest extends MyBussinesEvent {}
