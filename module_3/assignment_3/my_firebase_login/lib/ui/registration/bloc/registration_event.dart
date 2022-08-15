import 'package:equatable/equatable.dart';

/// Todo 10: Prepare bloc event for registration_bloc
///   - Events: [ TriggerRegistration ]

abstract class RegistrationEvent extends Equatable {}

class TriggerRegistration extends RegistrationEvent {
  final String email;
  final String password;

  TriggerRegistration(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}