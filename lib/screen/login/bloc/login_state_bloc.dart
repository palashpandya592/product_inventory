import 'package:product_app/model/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final LoginModel loginModel;

  LoginLoadedState(this.loginModel);
}

class LoginErrorState extends LoginState {}
