
// import '../../../domain/entities/user.dart';


import '../../../domain/entities/entities.dart';

abstract class MenuEvent {
  const MenuEvent();
}

class GetPdfMenu extends MenuEvent {
  const GetPdfMenu(this.data);
  final Menu data;
}

