import 'package:equatable/equatable.dart';

/// Todo 14: Prepare bloc state for login_bloc
///   - states: [LoginInitial], [LoginLoading], [LoginSucessful], [LoginFailed], [LoginNotRequired]
/// 

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessful extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailed extends LoginState {
  final String errorMsg;

  LoginFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

class LoginNotRequired extends LoginState {
  @override
  List<Object?> get props => [];
}
