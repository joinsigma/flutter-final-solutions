import 'package:equatable/equatable.dart';

///Events
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class TriggerRegister extends RegisterEvent {
  final String email;
  final String password;

  const TriggerRegister({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}