abstract class UserUpdateEvent {}

class UserUpdateInitialEvent extends UserUpdateEvent {}

class UpdateDataEvent extends UserUpdateEvent {
  final String? name;
  final String? email;
  final String? birth_date;
  final int? id;

  UpdateDataEvent(
    this.name,
    this.email,
    this.birth_date,
    this.id,
  );
}
