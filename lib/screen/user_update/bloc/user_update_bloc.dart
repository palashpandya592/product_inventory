import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/screen/user_update/bloc/user_update_event.dart';
import 'package:product_app/screen/user_update/bloc/user_update_state.dart';
import 'package:product_app/model/user_update_model.dart';
import 'package:product_app/services/user_update_service.dart';
import 'package:product_app/screen/widget/toast.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateModel? userUpdateModel;
  UpdateService updateService;

  UserUpdateBloc(this.updateService) : super(UserUpdateInitialState()) {
    on<UserUpdateEvent>((event, emit) async {
      if (event is UpdateDataEvent) {
        emit(UserUpdateLoadingState());
        await Future.delayed(
          Duration(),
          () async {
            userUpdateModel = await updateService.userUpdate(
                name: event.name,
                email: event.email,
                birth_date: event.birth_date,
                id: event.id);
            if (userUpdateModel?.status == true) {
              Toast.showToast(userUpdateModel!.message.toString());
              emit(
                UserUpdateLoadedState(userUpdateModel!),
              );
            } else {
              Toast.showToast(userUpdateModel!.message.toString());
            }
          },
        );
      }
    });
  }
}
