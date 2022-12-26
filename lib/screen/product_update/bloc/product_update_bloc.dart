import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/screen/product_update/bloc/product_update_event.dart';
import 'package:product_app/screen/product_update/bloc/product_update_state.dart';
import 'package:product_app/model/product_update_model.dart';
import 'package:product_app/services/product_update_service.dart';
import 'package:product_app/screen/widget/toast.dart';

class ProductUpdateBloc extends Bloc<ProductUpdateEvent, ProductUpdateState> {
  ProductUpdateModel? productUpdateModel;
  ProductUpdateService productUpdateService;

  ProductUpdateBloc(this.productUpdateService) : super(ProductUpdateInitial()) {
    on<ProductUpdateEvent>((event, emit) async {
      if (event is ProductUpdateDataEvent) {
        emit(ProductUpdateLoadingState());
        productUpdateModel = await productUpdateService.productUpdate(
          name: event.name,
          mrp: event.mrp,
          selling: event.selling,
          description: event.description,
          image: event.image,
          id: event.id,
        );
        if (productUpdateModel?.status == true) {
          Toast.showToast(productUpdateModel!.message.toString());
          emit(ProductUpdateLoadedState(productUpdateModel!));
        } else {
          Toast.showToast(productUpdateModel!.message.toString());
        }
      }
    });
  }
}
