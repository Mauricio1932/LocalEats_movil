abstract class LocalesEvent {
  const LocalesEvent();
}

class LocalGetRequest extends LocalesEvent {}
class GetMyLocals extends LocalesEvent {}

// class LocalSingleRequest extends LocalesEvent {
//   // const LocalSingleRequest(this.localId);
//   const LocalSingleRequest(this.localId);
//   final int localId;
// }

// class LocalSingleView extends LocalesEvent{
//   const LocalSingleView(this.localId);
//   final int localId;
// }

// class DeleteLocalSingleView extends LocalesEvent{
//   const DeleteLocalSingleView(this.localId);
//   final int localId;
// }
