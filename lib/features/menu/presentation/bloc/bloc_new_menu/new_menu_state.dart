import '../../../domain/entities/entities.dart';

enum NewMenuRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class NewMenuState {
  const NewMenuState({
    this.menu = const [],
    this.newMenuStatus = NewMenuRequest.unknown,
    // this.token = const {},
  });

  final List<Menu> menu;
  final NewMenuRequest newMenuStatus;
  // final Set<String> token;

  NewMenuState copyWith({
    List<Menu>? menu,
    NewMenuState? newMenuState,
    // Set<String>? token,
    required newMenuStatus,
  }) =>
      NewMenuState(
        menu: menu ?? this.menu,
        newMenuStatus: newMenuStatus ?? this.newMenuStatus,
      );
}
