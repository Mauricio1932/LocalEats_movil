import '../../../domain/entities/entities.dart';

enum MenuRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class MenuState {
  const MenuState({
    this.menu = const [],
    this.menuStatus = MenuRequest.unknown,
    // this.token = const {},
  });

  final List<Menu> menu;
  final MenuRequest menuStatus;
  // final Set<String> token;

  MenuState copyWith({
    List<Menu>? menu,
    MenuState? menuState,
    // Set<String>? token,
    required menuStatus,
  }) =>
      MenuState(
        menu: menu ?? this.menu,
        menuStatus: menuStatus ?? this.menuStatus,
      );
}
