import 'package:equatable/equatable.dart';

abstract class ProfileScreenEvent extends Equatable {
  const ProfileScreenEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends ProfileScreenEvent {}
