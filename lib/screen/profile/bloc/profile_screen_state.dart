import 'package:equatable/equatable.dart';
import 'package:product_app/model/profile_user_model.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object?> get props => [];
}

class ProfileScreenInitial extends ProfileScreenState {}

class ProfileScreenLoading extends ProfileScreenState {}

class ProfileScreenLoaded extends ProfileScreenState {
  final UserModel? userModel;
  const ProfileScreenLoaded(this.userModel);
}

class ProfileScreenError extends ProfileScreenState {
  final String? message;
  ProfileScreenError(this.message);
}
