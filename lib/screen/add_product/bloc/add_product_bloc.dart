import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/model/add_product_model.dart';
import 'package:product_app/services/add_product_service.dart';
import 'package:product_app/screen/add_product/bloc/add_product_event.dart';
import 'package:product_app/screen/add_product/bloc/add_product_state.dart';
import 'package:product_app/screen/widget/toast.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductModel? addProductModel;
  AddProductService addProductService;

  AddProductBloc(this.addProductService) : super(AddProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      if (event is AddProductDataEvent) {
        emit(AddProductLoadingState());
        await Future.delayed(
          Duration(),
          () async {
            addProductModel = await addProductService.addProduct(
              name: event.name,
              mrp: event.mrp,
              selling: event.selling,
              description: event.description,
              image: event.image,
            );
            if (addProductModel!.status == true) {
              Toast.showToast(addProductModel?.message.toString());
              emit(AddProductLoadedState(addProductModel!));
            } else {
              Toast.showToast(addProductModel?.message.toString());
            }
          },
        );
      }
    });
  }
}
