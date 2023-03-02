
import 'package:equatable/equatable.dart';

///States
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final bool isApiError;
  final bool isAuthTokenError;
  final bool isUidError;
  const LoginFailure(
      {required this.isApiError,
        required this.isAuthTokenError,
        required this.isUidError});
  @override
  List<Object?> get props => [isApiError, isAuthTokenError, isUidError];
}