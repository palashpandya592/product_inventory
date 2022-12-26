import 'package:product_app/model/add_product_model.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductLoadedState extends AddProductState {
  final AddProductModel addProductModel;

  AddProductLoadedState(this.addProductModel);
}

class AddProductErrorState extends AddProductState {}
