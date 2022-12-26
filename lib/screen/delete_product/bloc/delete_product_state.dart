import 'package:product_app/model/delete_product_model.dart';

abstract class DeleteProductState {}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductLoadingState extends DeleteProductState {}

class DeleteProductLoadedState extends DeleteProductState {
  final DeleteProductModel? deleteProductModel;

  DeleteProductLoadedState(this.deleteProductModel);
}

class DeleteProductErrorState extends DeleteProductState {}
