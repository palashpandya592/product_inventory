import 'package:product_app/model/product_update_model.dart';

abstract class ProductUpdateState {}

class ProductUpdateInitial extends ProductUpdateState {}

class ProductUpdateLoadingState extends ProductUpdateState {}

class ProductUpdateLoadedState extends ProductUpdateState {
  final ProductUpdateModel productUpdateModel;

  ProductUpdateLoadedState(this.productUpdateModel);
}

class ProductUpdateErrorState extends ProductUpdateState {}
