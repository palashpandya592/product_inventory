abstract class ProductUpdateEvent {}

class ProductUpdateInitialEvent extends ProductUpdateEvent {}

class ProductUpdateDataEvent extends ProductUpdateEvent {
  final String? name;
  final String? mrp;
  final String? selling;
  final String? description;
  final String? image;
  final int? id;

  ProductUpdateDataEvent(
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
    this.id,
  );
}
