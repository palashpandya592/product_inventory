import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/screen/delete_product/bloc/delete_product_event.dart';
import 'package:product_app/screen/delete_product/bloc/delete_product_state.dart';
import 'package:product_app/model/delete_product_model.dart';
import 'package:product_app/services/delete_product_service.dart';
import 'package:product_app/screen/widget/toast.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductModel? deleteProductModel;
  DeleteProductService deleteProductService;

  DeleteProductBloc(this.deleteProductService) : super(DeleteProductInitial()) {
    on<DeleteProductEvent>((event, emit) async {
      if (event is DeleteProductDataEvent) {
        emit(DeleteProductLoadingState());
        deleteProductModel =
            await deleteProductService.deleteProduct(id: event.id);
        if (deleteProductModel?.status == true) {
          Toast.showToast(deleteProductModel!.message.toString());
          emit(DeleteProductLoadedState(deleteProductModel!));
        } else {
          Toast.showToast(deleteProductModel!.message.toString());
        }
      }
    });
  }
}
