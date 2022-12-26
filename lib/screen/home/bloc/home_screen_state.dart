import 'package:equatable/equatable.dart';
import 'package:product_app/model/home_screen_model.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {
  final String message;

  HomeScreenLoading({required this.message});
}

class HomeScreenLoaded extends HomeScreenState {
  final List<Datum>? listItem;
  const HomeScreenLoaded(this.listItem);
}

class HomeScreenError extends HomeScreenState {
  final String? message;
  const HomeScreenError(this.message);
}
