import 'package:product_app/model/user_update_model.dart';

abstract class UserUpdateState {}

class UserUpdateInitialState extends UserUpdateState {}

class UserUpdateLoadingState extends UserUpdateState {}

class UserUpdateLoadedState extends UserUpdateState {
  final UserUpdateModel userUpdateModel;

  UserUpdateLoadedState(this.userUpdateModel);
}

class UserUpdateErrorState extends UserUpdateState {}
