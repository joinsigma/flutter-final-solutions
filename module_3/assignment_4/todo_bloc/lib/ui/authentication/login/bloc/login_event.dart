import 'package:equatable/equatable.dart';

///Events
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class TriggerLogin extends LoginEvent {
  final String email;
  final String password;

  const TriggerLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}