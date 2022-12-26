abstract class RegisterEvent {}

class InitialEvent extends RegisterEvent {}

class SendDataEvent extends RegisterEvent {
  final String? name;
  final String? email;
  final String? password;
  final String? password_confirmation;
  final String? birth_date;
  final String? gender;
  final String? image;

  SendDataEvent(
    this.name,
    this.email,
    this.password,
    this.password_confirmation,
    this.birth_date,
    this.gender,
    this.image,
  );
}
