abstract class DeleteProductEvent {}

class InitialEvent extends DeleteProductEvent {}

class DeleteProductDataEvent extends DeleteProductEvent {
  final int? id;

  DeleteProductDataEvent(this.id);
}
