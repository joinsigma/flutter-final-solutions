import 'package:equatable/equatable.dart';

/// Todo 13: Prepare bloc event for login_bloc
///   - event: [TriggerLogin], [ValidateUserStatus]
/// 

abstract class LoginEvent extends Equatable {}

class TriggerLogin extends LoginEvent {
  final String email;
  final String password;

  TriggerLogin(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class ValidateUserStatus extends LoginEvent {
  @override
  List<Object?> get props => [];
}