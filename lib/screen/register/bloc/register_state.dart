import 'package:product_app/model/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final RegisterModel registerModel;

  RegisterLoadedState(this.registerModel);
}

class RegisterErrorState extends RegisterState {}
