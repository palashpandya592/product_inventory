abstract class LoginEvent {}

class InitialEvent extends LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String? email;
  final String? password;

  LoginUserEvent(this.email, this.password);
}
