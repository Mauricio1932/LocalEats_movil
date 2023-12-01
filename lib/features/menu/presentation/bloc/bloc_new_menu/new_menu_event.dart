import 'package:localeats/features/menu/domain/entities/new_menu_entities.dart';

abstract class NewMenuEvent {
  const NewMenuEvent();
}

class PostPdfMenu extends NewMenuEvent {
  const PostPdfMenu(this.data);
  final NewMenu data;
}

class ResetMenu extends NewMenuEvent{}