abstract class AddProductEvent {}

class InitialEvent extends AddProductEvent {}

class AddProductDataEvent extends AddProductEvent {
  final String? name;
  final String? mrp;
  final String? selling;
  final String? description;
  final String? image;

  AddProductDataEvent(
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
  );
}
