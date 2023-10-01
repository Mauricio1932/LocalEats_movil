abstract class LocalSingleEvent {
  const LocalSingleEvent();
}




class LocalSingleView extends LocalSingleEvent{
  const LocalSingleView(this.localId);
  final int localId;
}


class DeleteViewLocal extends LocalSingleEvent{
  const DeleteViewLocal (this.localId);
  final int localId;
}