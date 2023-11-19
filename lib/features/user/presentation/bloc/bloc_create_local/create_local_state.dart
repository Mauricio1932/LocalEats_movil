import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';

import '../../../../locales/domain/entities/local.dart';

enum LocalRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class CreateLocalState {
  const CreateLocalState({
    this.newLocals = const [],
    this.newLocalStatus = LocalRequest.unknown,
  });

  final List<Local> newLocals;
  final LocalRequest newLocalStatus;

  CreateLocalState copyWith({
    List<Local>? newLocals,
    LocalRequest? newLocalStatus,
  }) =>
      CreateLocalState(
        newLocals: newLocals ?? this.newLocals,
        newLocalStatus: newLocalStatus ?? this.newLocalStatus,
      );
}
