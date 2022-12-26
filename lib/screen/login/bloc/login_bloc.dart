import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:product_app/screen/widget/toast.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/screen/login/bloc/login_event_bloc.dart';
import 'package:product_app/screen/login/bloc/login_state_bloc.dart';
import 'package:product_app/model/login_model.dart';
import 'package:product_app/services/login_service.dart';
import 'package:product_app/utils/app_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginModel? loginModel;
  LoginService loginService;

  LoginBloc(this.loginService) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(LoginLoadingState());
        await Future.delayed(Duration(), () async {
          loginModel = await loginService.userLogin(
              email: event.email, password: event.password);
          if (loginModel != null) {
            if (loginModel!.status == true) {
              Toast.showToast("Successfully Login");
            } else {
              Toast.errorToast("Record Not Match");
            }
          } else {
            Toast.errorToast("Record Not Match");
          }
          AppPreference.set(AppStrings.userToken, loginModel!.token);
          AppPreference.set(AppStrings.loginStatus, loginModel!.status);

          emit(
            LoginLoadedState(loginModel!),
          );
        });
      }
    });
  }
}
