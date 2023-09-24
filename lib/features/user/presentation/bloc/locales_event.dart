abstract class LocalesEvent {
  const LocalesEvent();
}

class LocalRequest extends LocalesEvent {}

class LocalView extends LocalesEvent{
  const LocalView(this.localId);
  final int localId;
}
