import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';

import '../../../../locales/domain/entities/local.dart';

abstract class CreateLocalEvent {
  const CreateLocalEvent();
}

class CreateLocalRequest extends CreateLocalEvent {
  const CreateLocalRequest(this.data);
  final NewLocal data;
}
