import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:product_app/screen/register/bloc/register_event.dart';
import 'package:product_app/screen/register/bloc/register_state.dart';
import 'package:product_app/model/register_model.dart';
import 'package:product_app/services/register_service.dart';
import 'package:product_app/screen/widget/toast.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterModel? registrationModel;
  RegisterService registerService;

  RegisterBloc(this.registerService) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is SendDataEvent) {
        emit(RegisterLoadingState());
        await Future.delayed(
          Duration(),
          () async {
            registrationModel = await registerService.userRegister(
                name: event.name,
                email: event.email,
                password: event.password,
                password_confirmation: event.password_confirmation,
                birth_date: event.birth_date,
                gender: event.gender);
            if (registrationModel != null) {
              if (registrationModel!.status == true) {
                Toast.showToast('Register Successfully');
              } else {
                Toast.errorToast('The email has already been taken.');
              }
            } else {
              Toast.errorToast('The email has already been taken.');
            }
            emit(RegisterLoadedState(registrationModel!));
          },
        );
      }
    });
  }
}
